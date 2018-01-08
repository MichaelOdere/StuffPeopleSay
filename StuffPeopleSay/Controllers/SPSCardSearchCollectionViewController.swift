import UIKit

class SPSCardSearchCollectionViewController:SPSSearchCollectionViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lpgr = UILongPressGestureRecognizer(target: self, action:  #selector(SPSDeckSearchCollectionViewController.handleLongPress(gestureReconizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        superCollectionView.addGestureRecognizer(lpgr)
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
// TODO: MOVE HERE

//extension SPSDeckSearchCollectionViewController {
//    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
//        let p = gestureReconizer.location(in: superCollectionView)
//        let indexPath = superCollectionView.indexPathForItem(at: p)
//        if let index = indexPath {
//            let cell = superCollectionView.cellForItem(at: index) as! DeckCell
//            cell.name.isEnabled = true
//            cell.name.becomeFirstResponder()
//        } else {
//            print("Could not find index path")
//        }
//    }
//}
//
//extension SPSDeckSearchCollectionViewController:UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.isEnabled = false
//    }
//}

