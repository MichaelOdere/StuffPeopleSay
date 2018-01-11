import UIKit

class DeckEditViewController: UIViewController{

    var gameStore:GameStore!
    var deckView:DeckView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deckView = DeckView(frame: view.frame)
        deckView.collectionView.delegate = self
        view.addSubview(deckView)
        
        deckView.setDataSource(gameStore: gameStore)
    }
}

extension DeckEditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
