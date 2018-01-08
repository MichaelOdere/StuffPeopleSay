import UIKit

class CardTextfield:UITextField{
    var boardCardId:String!
    var indexPath:IndexPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        textAlignment = .center
        returnKeyType = .done
    }
}
