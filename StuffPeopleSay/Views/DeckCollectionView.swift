import UIKit

class DeckCollectionView: UICollectionView{
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = BingoPalette.vanillaBackgroundColor
        register(DeckCell.self, forCellWithReuseIdentifier: "DeckCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
