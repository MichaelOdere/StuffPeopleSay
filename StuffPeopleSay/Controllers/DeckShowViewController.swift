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
        
        let deck = gameStore.decks[indexPath.row]
        let countActive = deck.activeCards()
        if countActive >= 25 {
            selectDeck?.sendSelectedDeck(valueSent: gameStore.decks[indexPath.row])
            dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Not Enough Cards!", message: "Currently you have \(countActive)/25 cards in the \(deck.name) deck. Please activate more cards or select a different deck.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

