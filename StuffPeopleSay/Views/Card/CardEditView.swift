import UIKit

class CardEditView:EditView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewTypeDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardEditView: CollectionViewType{
    func getCollectionView() -> UICollectionView {
        let layout = DeckCollectionViewLayout()
        return CardCollectionView(frame: frame, collectionViewLayout: layout)
    }
}


