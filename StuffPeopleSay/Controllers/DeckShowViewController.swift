import UIKit

protocol SelectDeckProtocol {
    func sendSelectedDeck(valueSent: Deck)
}

class DeckShowViewController:UIViewController{
    var selectDeck:SelectDeckProtocol?
    
    var deckEditView:DeckEditView!
    var gameStore:GameStore!
    let deckDataSource = DeckCollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: 75))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Decks")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action:  #selector(DeckShowViewController.dismissVC))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        
        deckEditView = DeckEditView(frame: CGRect(x: 0, y: navBar.frame.height, width: self.view.frame.width, height: self.view.frame.height))

        deckEditView.collectionView.delegate = self
        view.addSubview(deckEditView)
        
        deckDataSource.delegate = self
        deckEditView.setDataSource(dataSource: deckDataSource)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
}

extension DeckShowViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let deck = gameStore.decks[indexPath.row]
        let countActive = deck.activeCards()
        if countActive >= 25 {
            selectDeck?.sendSelectedDeck(valueSent: gameStore.decks[indexPath.row])
            dismissVC()
        }else{
            let alert = UIAlertController(title: "Not Enough Cards!", message: "Currently you have \(countActive)/25 cards in the \(deck.name) deck. Please activate more cards or select a different deck.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension DeckShowViewController: DeckCollectionViewDelegate {
    var gs: GameStore {
        return gameStore
    }
    
    var deckView: DeckEditView {
        return deckEditView
    }
}
