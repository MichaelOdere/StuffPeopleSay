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
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        var backgroundVC = fromVC
        var foregroundVC = toVC
        
        if operation == .pop{
            backgroundVC = toVC
            foregroundVC = fromVC
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
