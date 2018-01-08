import UIKit

class DeckCell:SPSCollectionViewCell{
    var deckId:String!
    var indexPath:IndexPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
    }
}
