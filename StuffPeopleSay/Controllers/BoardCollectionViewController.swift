import UIKit

class BoardCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var game: Game!
    var gameStore: GameStore!
    var selectedIndexPath: IndexPath!

    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.my.boards.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = "BoardCollectionViewCell"
        let cellOptional = collectionView.dequeueReusableCell(withReuseIdentifier: id,
                                                              for: indexPath) as? BoardCollectionViewCell
        guard let cell =  cellOptional else {
            fatalError("BoardCollectionViewCell not found.")
        }
        let cardCount = game.my.getCardsActive(index: indexPath.row)
        let cardString = cardCount == 1 ? "card" : "cards"
        cell.titleLabel.text = String(cardCount) + " \(cardString) active"
        cell.bingoDataSource.deck = game.my.boards[indexPath.row].boardDeck
        cell.setDelegation()
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vcOptional = sb.instantiateViewController(withIdentifier: "BingoController") as? BingoViewController
        guard let vc = vcOptional else {
            fatalError("BingoController not found.")
        }
        vc.users = self.game.opponents
        vc.board = self.game.my.boards[indexPath.row]
        vc.status = self.game.status
        vc.gameId = self.game.gameId
        vc.gameStore = self.gameStore
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BoardCollectionViewController: ZoomViewController {
    func zoomingCollectionView(for transition: ZoomTransitioningDelegate) -> UICollectionView? {
        if let indexPath = selectedIndexPath {
            guard let cell = collectionView?.cellForItem(at: indexPath) as? BoardCollectionViewCell else {
                fatalError("Cell at index path not found.")
            }
            return cell.board
        }
        return nil
    }
}
