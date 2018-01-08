import UIKit

class SPSDeckSearchCollectionViewController:SPSSearchCollectionViewController{
   
    var isEditingATextField:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lpgr = UILongPressGestureRecognizer(target: self, action:  #selector(SPSDeckSearchCollectionViewController.handleLongPress(gestureReconizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        superCollectionView.addGestureRecognizer(lpgr)
        superCollectionView.register(DeckCell.self, forCellWithReuseIdentifier: "DeckCell")

        searchDelegate = self
    }
    
    func getFilteredDeck(id: String)->Deck{
        var deck:Deck?
        if let index = gameStore.decks.index(where: { $0.id == id }) {
            deck = gameStore.decks[index]
        }
        assert(deck != nil, "Cannot find id for DECK when searching!")
        return deck!
    }
}

extension SPSDeckSearchCollectionViewController {
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        let p = gestureReconizer.location(in: superCollectionView)
        let indexPath = superCollectionView.indexPathForItem(at: p)
        if let index = indexPath {
            let cell = superCollectionView.cellForItem(at: index) as! DeckCell
            cell.name.isEnabled = true
            cell.name.becomeFirstResponder()
        } else {
            print("Could not find index path")
        }
    }
}

extension SPSDeckSearchCollectionViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isEditingATextField = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isEnabled = false
        isEditingATextField = false
    }
}

extension SPSDeckSearchCollectionViewController:SPSSearchCollectionViewControllerDelegate{
    func getFilteredObjectsFromSearchText(name: String) -> [SearchableObject] {
        return gameStore.decks.filter({( deck : Deck) -> Bool in
            return deck.name.lowercased().contains(name.lowercased())
        })
    }
}
