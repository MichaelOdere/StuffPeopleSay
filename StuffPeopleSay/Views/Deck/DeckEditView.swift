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
        return DeckCollectionView(frame: frame, collectionViewLayout: layout)
    }
}

