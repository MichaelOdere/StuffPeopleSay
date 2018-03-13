import UIKit

class HomeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setTitleColor(UIColor.white, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
