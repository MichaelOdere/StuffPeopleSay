import UIKit

class DeckEditView:EditView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        collectionViewTypeDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DeckEditView: CollectionViewType{
    func getCollectionView() -> UICollectionView {
        let layout = DeckCollectionViewLayout()
        let cv = DeckCollectionView(frame: frame, collectionViewLayout: layout)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action:  #selector(DeckEditView.handleLongPress(gestureReconizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        cv.addGestureRecognizer(lpgr)
     
        return cv
    }
}

extension DeckEditView {
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        print("long press")
        let p = gestureReconizer.location(in: collectionView)
        let indexPath = collectionView.indexPathForItem(at: p)
        if let index = indexPath {
            let cell = collectionView.cellForItem(at: index) as! DeckCell
            cell.name.isEnabled = true
            cell.name.becomeFirstResponder()
        } else {
            print("Could not find index path")
        }
    }
}
