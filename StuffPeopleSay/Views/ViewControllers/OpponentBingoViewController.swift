import UIKit

class OpponentBingoViewController:UIViewController{
    var user:User?
    let pieceTransparency:CGFloat = 0.2
    var bingoGame:BingoGame = BingoGame()

    @IBOutlet var collectionView: UICollectionView!
    var bingoDataSource:BingoCollectionView!

    override func viewDidLoad() {
        bingoDataSource = BingoCollectionView()
        
        bingoDataSource.bingoGame = bingoGame
        if let board = self.user?.boards[0]{
            bingoDataSource.deck = board.deck.cards
        }else{
            bingoDataSource.deck = []
        }
        
        collectionView.dataSource = bingoDataSource
        collectionView.delegate = bingoDataSource
        
        self.navigationItem.title = user?.name
    }
    
}
