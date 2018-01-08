import UIKit

class SPSShowCardSearchCollectionViewController: SPSCardSearchCollectionViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var collectionViewBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var toolBarView: UIView!
    
    var deck:Deck!
    var tempDeck:Deck!
    var filteredCards = [Card]()
    var selectedCards = [String]()
    var newDeck:Bool!
    
    override func viewDidLoad() {
        collectionViewControllerDelegate = self
        searchDelegate =  self
        
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.backgroundColor = BingoPalette.vanillaBackgroundColor
        tempDeck = deck.copyDeck()
                
        setupButtons()
    }
    
    func setupButtons(){
        cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)
    }
    
    @objc func cancel(sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    @objc func save(sender: UIButton){
        deck.name = tempDeck.name
        deck.cards = tempDeck.cards
        if newDeck{
            gameStore.decks.append(deck)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension SPSShowCardSearchCollectionViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering(){
            return filteredObjects.count
        }
        return deck.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        cell.cellSelected()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.state = .selected
        let card: Card
        
        if isFiltering() {
            card = getFilteredCard(id: filteredObjects[indexPath.row].id)
        } else {
            card = deck.cards[indexPath.row]
        }
        cell.name.isEnabled = false
        cell.name.boardCardId = card.id
        cell.name.text = card.name
        cell.name.indexPath = indexPath
        cell.name.addTarget(self, action: #selector(textChanged(sender:)), for: UIControlEvents.editingChanged)
        cell.name.delegate = self
        return cell
    }
    
    func getFilteredCard(id: String)->Card{
        var card:Card?
        if let index = deck.cards.index(where: { $0.id == id }) {
            card = deck.cards[index]
        }
        assert(card != nil, "Cannot find id for CARD when searching!")
        return card!
    }
}

extension SPSShowCardSearchCollectionViewController:SPSCollectionViewControllerDelegate{
    func getCollectionview() -> UICollectionView {
        return collectionView
    }
    
    func getCollectionviewBottomConstraint() -> NSLayoutConstraint {
        return collectionViewBottomLayoutConstraint
    }
    
    func getTextChanged(sender: UITextField){
        if let sender = sender as? CardTextfield {
            tempDeck.cards[sender.indexPath.row].name = sender.text!
        }else{
            print("Not cardtextfield")
        }
    }
}

extension SPSShowCardSearchCollectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension SPSShowCardSearchCollectionViewController: SPSSearchCollectionViewControllerDelegate {
    func getFilteredObjectsFromSearchText(name: String) -> [SearchableObject] {
        return deck.cards.filter({( card : Card) -> Bool in
            return card.name.lowercased().contains(name.lowercased())
        })
    }
}
