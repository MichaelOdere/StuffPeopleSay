import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var board:UICollectionView!
    var bingoDataSource:BingoCollectionView = BingoCollectionView()
    
    func setDelegation(){
        board.dataSource = bingoDataSource
        board.delegate = bingoDataSource
    }
}
