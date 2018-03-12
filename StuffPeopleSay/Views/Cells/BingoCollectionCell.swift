import UIKit

class BingoCollectionCell: UICollectionViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var pieceView: PieceView!

    var xIndex: Int!
    var yIndex: Int!
}
