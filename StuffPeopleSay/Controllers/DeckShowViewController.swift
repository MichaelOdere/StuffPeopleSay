import UIKit

protocol SelectDeckProtocol {
    func sendSelectedDeck(valueSent: Deck)
}

class DeckShowViewController:DeckEditViewController{
    var selectDeck:SelectDeckProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DeckShowViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectDeck?.sendSelectedDeck(valueSent: gameStore.decks[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
