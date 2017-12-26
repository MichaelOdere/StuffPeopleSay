import UIKit

class DeckViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var decks:[Deck]!
    
    override func viewDidLoad() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}
extension DeckViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decks.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
        if indexPath.row == decks.count{
            cell.name.text = "Create a new Deck!"
        }else{
            let deck = decks[indexPath.row]
            cell.name.text = deck.name
        }
        return cell
    }
}
