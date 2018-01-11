import UIKit

class DeckEditViewController: UIViewController{

    var gameStore:GameStore!
    var deckEditView:DeckEditView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deckEditView = DeckEditView(frame: view.frame)
        deckEditView.collectionView.delegate = self
        view.addSubview(deckEditView)
        
        deckEditView.setDataSource(gameStore: gameStore)
    }
}

extension DeckEditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
