import UIKit

class CardsViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var deck:Deck!
    var filteredCards = [Card]()
    var selectedCards = [String]()

    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
                
        self.collectionView.backgroundColor = BingoPalette.vanillaBackgroundColor

        nameTextField.text = deck.name

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
        dismiss(animated: true, completion: nil)
    }
}
extension CardsViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deck.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
        let card = deck.cards[indexPath.row]
        
        cell.name.text = card.name
        return cell
    }
}



