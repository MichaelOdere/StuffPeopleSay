import UIKit

class OpponentBingoViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    var user: User?
    let pieceTransparency: CGFloat = 0.2
    var bingoGame: BingoBoard = BingoBoard()
    var bingoDataSource: BingoCollectionView!

    override func viewDidLoad() {
        bingoDataSource = BingoCollectionView()
        bingoDataSource.bingoGame = bingoGame

        if let board = self.user?.boards[0] {
            bingoDataSource.deck = board.boardDeck
        } else {
            bingoDataSource.deck = BoardDeck(cards: [])
        }

        collectionView.dataSource = bingoDataSource
        collectionView.delegate = bingoDataSource

        self.navigationItem.title = user?.name
    }
}
