import UIKit

@objc
protocol ZoomViewController {
    func zoomingCollectionView(for transition: ZoomTransitioningDelegate) -> UICollectionView?
}

enum TransitionState{
    case initial
    case final
}

class ZoomTransitioningDelegate:NSObject{
    var transitionDuration = 0.5
    var operation: UINavigationControllerOperation = .none
    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7)
    
    typealias ZoomingViews = (collectionView: UICollectionView, imageView: UIView)
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, foregroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews){
        
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            
            foregroundViewController.view.transform =  CGAffineTransform(translationX: 0, y: foregroundViewController.view.frame.height)
            foregroundViewController.view.alpha = 0
            snapshotViews.collectionView.frame = containerView.convert(viewsInBackground.collectionView.frame, from: viewsInBackground.collectionView.superview)
        
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
        
            foregroundViewController.view.transform =  CGAffineTransform.identity
            foregroundViewController.view.alpha = 1
            
            snapshotViews.collectionView.frame = containerView.convert(viewsInForeground.collectionView.frame, from: viewsInForeground.collectionView.superview)
        }
    }
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        var backgroundVC = fromVC
        var foregroundVC = toVC
        
        if operation == .pop{
            backgroundVC = toVC
            foregroundVC = fromVC
        }
        
        let maybeBackgroundView = (backgroundVC as? ZoomViewController)?.zoomingCollectionView(for: self)
        let maybeForegroundView = (foregroundVC as? ZoomViewController)?.zoomingCollectionView(for: self)

        assert(maybeBackgroundView != nil, "Cannot find view in background")
        assert(maybeForegroundView != nil, "Cannot find view in foreground")
        
        let backgroundView = maybeBackgroundView!
        let foregroundView = maybeForegroundView!
        
        let viewSnapshot:UICollectionView = UICollectionView(frame: backgroundView.frame, collectionViewLayout: BingoCollectionViewLayout())
        
//        viewSnapshot.register(cell.classForCoder, forCellWithReuseIdentifier: "BingoCell")
//        viewSnapshot.delegate = backgroundView.delegate
//        viewSnapshot.dataSource = backgroundView.dataSource

        viewSnapshot.backgroundColor = backgroundView.backgroundColor
        
        viewSnapshot.layer.masksToBounds = true
        
        backgroundView.isHidden = true
        foregroundView.isHidden = true
        
        let foregroundViewBackgroundColor = foregroundVC.view.backgroundColor
        foregroundVC.view.backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.white
        
        containerView.addSubview(backgroundVC.view)
        containerView.addSubview(foregroundVC.view)
        containerView.addSubview(viewSnapshot)

        var preTransitionState = TransitionState.initial
        var postTransitionState = TransitionState.final
        
        if operation == .pop{
            preTransitionState = .final
            postTransitionState = .initial

        }
        
       configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundVC, foregroundViewController: foregroundVC, viewsInBackground: (backgroundView, backgroundView), viewsInForeground: (foregroundView,foregroundView), snapshotViews: (viewSnapshot, viewSnapshot))
        
        foregroundVC.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundVC, foregroundViewController: foregroundVC, viewsInBackground: (backgroundView, backgroundView), viewsInForeground: (foregroundView,foregroundView), snapshotViews: (viewSnapshot, viewSnapshot))
            
        }) { (finished) in
            backgroundVC.view.transform = CGAffineTransform.identity
            
            viewSnapshot.removeFromSuperview()
            backgroundView.isHidden = false
            foregroundView.isHidden = false
            
            foregroundVC.view.backgroundColor = foregroundViewBackgroundColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension ZoomTransitioningDelegate: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       
        if fromVC is ZoomViewController && toVC is ZoomViewController{
            self.operation = operation
            return self
        }else{
            return nil
        }
    }
}
