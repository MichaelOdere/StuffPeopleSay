import UIKit

protocol MyProtocol {
    func sendSelectedDeck(valueSent: Deck)
}

class SPSShowDeckSearchCollectionViewController:SPSDeckSearchCollectionViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftToolBarButton: UIButton!
    @IBOutlet weak var rightToolBarButton: UIButton!
    @IBOutlet weak var collectionViewBottomLayoutConstraint: NSLayoutConstraint!

    var myDelegate:MyProtocol?

    override func viewDidLoad() {
        collectionViewControllerDelegate = self
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

extension SPSShowDeckSearchCollectionViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredObjects.count
        }
        return gameStore.decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myDelegate?.sendSelectedDeck(valueSent: gameStore.decks[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
        let deck: Deck?
        if isFiltering() {
            deck = getFilderedDeck(id: filteredObjects[indexPath.row].id)
        } else {
            deck = gameStore.decks[indexPath.row]
        }
        cell.name.text = deck?.name
        cell.deckId = deck?.id
        
        if selectedObjects.contains(cell.deckId){
            cell.alpha = cell.selectedAlphaValue
        }else{
            cell.alpha = cell.deSelectedAlphaValue
        }
        return cell
    }
    
    func getFilderedDeck(id: String)->Deck?{
        if let index = gameStore.decks.index(where: { $0.id == id }) {
            return gameStore.decks[index]
        }
        return nil
    }
}

extension SPSShowDeckSearchCollectionViewController{
    @objc func toolBarButtons(sender: UIButton) {
        if sender.tag == 0{
           self.dismiss(animated: true, completion: nil)
        } else if sender.tag == 1{
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension SPSShowDeckSearchCollectionViewController:SPSCollectionViewControllerDelegate {
    func getCollectionview() -> UICollectionView {
        return collectionView
    }
    
    func getCollectionviewBottomConstraint() -> NSLayoutConstraint {
        return collectionViewBottomLayoutConstraint
    }
    
    func getTextChanged(sender:UITextField) {
        print("TEXT CHANGED!")
    }
}

