import UIKit

class CardTextfield:UITextField{
    var boardCardId:String!
    var indexPath:IndexPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        returnKeyType = .done
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        returnKeyType = .done
    }
}
