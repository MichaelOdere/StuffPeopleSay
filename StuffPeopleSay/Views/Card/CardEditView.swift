import UIKit

class CardEditView:EditView {
    
    let cardDataSource = CardCollectionViewDataSource()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewTypeDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataSource(deck: Deck){
        cardDataSource.deck = deck
        collectionView.dataSource = cardDataSource
    }
}

extension CardEditView: CollectionViewType{
    func getCollectionView() -> UICollectionView {
        let layout = DeckCollectionViewLayout()
        return CardCollectionView(frame: frame, collectionViewLayout: layout)
    }
}


