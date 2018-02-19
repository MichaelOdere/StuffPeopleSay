import UIKit

public struct BingoPalette {
    static public let backgroundColor = UIColor(r: 0, g: 0, b: 0)
    static public let vanillaBackgroundColor = UIColor(r: 242, g: 242, b: 235)
    static public let silverBackgroundColor = UIColor(r: 214, g: 215, b: 216)
    static public let bingoCellBackgroundColor = UIColor(r: 54, g: 80, b: 98)

    static public let SPSred = UIColor(r: 240, g: 93, b: 94)
    static public let SPSgrey = UIColor(r: 231, g: 236, b: 239)
    static public let SPSlightBlue = UIColor(r: 142, g: 220, b: 230)
    static public let SPSgreen = UIColor(r: 85, g: 139, b: 110)
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
