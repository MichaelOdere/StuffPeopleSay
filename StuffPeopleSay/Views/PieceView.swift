import UIKit

class PieceView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.size.width)
        UIColor.red.setFill()
        path.fill()
    }
}
