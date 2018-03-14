import UIKit

public struct BingoPalette {
    static public let backgroundColor = UIColor(red: 0, green: 0, blue: 0)
    static public let vanillaBackgroundColor = UIColor(red: 242, green: 242, blue: 235)
    static public let silverBackgroundColor = UIColor(red: 245, green: 245, blue: 245)
    static public let bingoCellBackgroundColor = UIColor(red: 54, green: 80, blue: 98)

    static public let SPSred = UIColor(red: 240, green: 93, blue: 94)
    static public let SPSgrey = UIColor(red: 231, green: 236, blue: 239)
    static public let SPSlightBlue = UIColor(red: 142, green: 220, blue: 230)
    static public let SPSgreen = UIColor(red: 85, green: 139, blue: 110)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
