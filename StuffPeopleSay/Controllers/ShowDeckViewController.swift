import UIKit

protocol MyProtocol {
    func sendSelectedDeck(valueSent: Deck)
}

class ShowDeckViewController:DeckViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftToolBarButton: UIButton!
    @IBOutlet weak var rightToolBarButton: UIButton!
    
    var delegate:MyProtocol?

    override func viewDidLoad() {
        super.superCollectionView = collectionView
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = BingoPalette.vanillaBackgroundColor

        rightToolBarButton.setTitle("Save", for: .normal)
        rightToolBarButton.addTarget(self, action: #selector(toolBarButtons(sender:)), for: .touchUpInside)
        rightToolBarButton.tag = 0
        
        leftToolBarButton.setTitle("Cancel", for: .normal)
        leftToolBarButton.addTarget(self, action: #selector(toolBarButtons(sender:)), for: .touchUpInside)
        leftToolBarButton.tag = 1
    }
}

extension ShowDeckViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredDecks.count
        }
        return gameStore.decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.sendSelectedDeck(valueSent: gameStore.decks[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
        let deck: Deck
        if isFiltering() {
            deck = filteredDecks[indexPath.row]
        } else {
            deck = gameStore.decks[indexPath.row]
        }
        cell.name.text = deck.name
        cell.deckId = deck.deckId
        
        if selectedDecks.contains(cell.deckId){
            cell.alpha = cell.selectedAlphaValue
        }else{
            cell.alpha = cell.deSelectedAlphaValue
        }
        return cell
    }
}
extension ShowDeckViewController{
    @objc func toolBarButtons(sender: UIButton) {
        if sender.tag == 0{
           self.dismiss(animated: true, completion: nil)
        } else if sender.tag == 1{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
