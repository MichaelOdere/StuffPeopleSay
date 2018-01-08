import UIKit

class CardsViewController: SPSCollectionViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var collectionViewBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var toolBarView: UIView!
    
//    var gameStore:GameStore!
    var deck:Deck!
    var tempDeck:Deck!
    var filteredCards = [Card]()
    var selectedCards = [String]()
    var newDeck:Bool!
    
    override func viewDidLoad() {
        SPSDelegate = self

        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        self.collectionView.backgroundColor = BingoPalette.vanillaBackgroundColor
        tempDeck = deck.copyDeck()
        
        nameTextField.text = deck.name
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        nameTextField.addTarget(self, action: #selector(nameTextChanged(sender:)), for: UIControlEvents.editingChanged)
        
        setupButtons()
    }
    
    func setupButtons(){
        cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)
    }
    
    @objc func cancel(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    @objc func save(sender: UIButton){
        deck.name = tempDeck.name
        deck.cards = tempDeck.cards
        if newDeck{
            gameStore.decks.append(deck)
        }
        dismiss(animated: true, completion: nil)
    }
    
}
extension CardsViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max(deck.cards.count, 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        if indexPath.row < deck.cards.count{
            let card = deck.cards[indexPath.row]
            cell.name.boardCardId = card.boardCardId
            cell.name.text = card.name
        }
        cell.name.indexPath = indexPath
        cell.name.addTarget(self, action: #selector(textChanged(sender:)), for: UIControlEvents.editingChanged)
        cell.name.delegate = self
        return cell
    }
    
    @objc func textChanged(sender: CardTextfield){
        tempDeck.cards[sender.indexPath.row].name = sender.text
    }
    @objc func nameTextChanged(sender: UITextField){
        tempDeck.name = sender.text!
    }
}

extension CardsViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CardsViewController:SPSCollectionViewControllerDelegate{
    func getCollectionview() -> UICollectionView {
        return collectionView
    }
    
    func getCollectionviewBottomConstraint() -> NSLayoutConstraint {
        return collectionViewBottomLayoutConstraint
    }
    
    
}
