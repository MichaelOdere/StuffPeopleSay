import UIKit

class DeckEditView:EditView {
 
    let deckDataSource = DeckCollectionViewDataSource()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewTypeDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataSource(gameStore: GameStore){
        deckDataSource.gameStore = gameStore
        collectionView.dataSource = deckDataSource
    }
}

extension DeckEditView: CollectionViewType{
    func getCollectionView() -> UICollectionView {
        let layout = DeckCollectionViewLayout()
        return DeckCollectionView(frame: frame, collectionViewLayout: layout)
    }
}

