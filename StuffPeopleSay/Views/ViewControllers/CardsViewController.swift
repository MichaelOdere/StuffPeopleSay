import UIKit

class CardsViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var deck:Deck!
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.backgroundColor = BingoPalette.vanillaBackgroundColor
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

