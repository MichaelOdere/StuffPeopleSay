import UIKit

class DeckEditView:EditView {
 
    let deckDataSource = DeckCollectionViewDataSource()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataSource(gameStore: GameStore){
        deckDataSource.gameStore = gameStore
        collectionView.dataSource = deckDataSource
    }
}

