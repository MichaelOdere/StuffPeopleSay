import UIKit

class DeckCell:UICollectionViewCell{
    @IBOutlet weak var name: UILabel!
    var deckId:String!
    var hasBeenSelected:Bool = false
    var deSelectedAlphaValue:CGFloat = 1.0
    var selectedAlphaValue:CGFloat = 0.5

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
    }
}
