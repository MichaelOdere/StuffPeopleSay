import UIKit

// TODO make textfield when strong reference cycle is fixed
class CardTextfield: UILabel {
    var id: String!
    var indexPath: IndexPath!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        textAlignment = .center
//        returnKeyType = .done
        isEnabled = false
    }
}
