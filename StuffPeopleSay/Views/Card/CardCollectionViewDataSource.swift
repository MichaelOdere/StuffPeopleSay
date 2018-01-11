import UIKit

class CardCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var deck:Deck!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if isFiltering(){
//            return filteredObjects.count
//        }
        return deck.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
//        cell.cellSelected()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
//        cell.state = .selected
        let card: Card
        
//        if isFiltering() {
//            card = getFilteredCard(id: filteredObjects[indexPath.row].id)
//        } else {
//            card = deck.cards[indexPath.row]
//        }
        card = deck.cards[indexPath.row]
//        cell.name.isEnabled = false
        cell.name.id = card.id
        cell.name.text = card.name
        cell.name.indexPath = indexPath
        //        cell.name.addTarget(self, action: #selector(textChanged(sender:)), for: UIControlEvents.editingChanged)
        //        cell.name.delegate = self
        return cell
    }
}
