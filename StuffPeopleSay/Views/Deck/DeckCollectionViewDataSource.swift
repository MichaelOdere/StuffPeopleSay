import UIKit

protocol DeckSearchCollectionViewDelegate: class {
    func isFiltering()->Bool
    var filteredDecks:[Deck] { get }
//    var selectedDecks:[String] { get }
}

class DeckCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    var gameStore:GameStore!
    weak var searchDelegate:DeckSearchCollectionViewDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sd = searchDelegate {
            if sd.isFiltering(){
                return searchDelegate!.filteredDecks.count
            }
        }
        return gameStore.decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
        var deck = gameStore.decks[indexPath.row]
        
        if let sd = searchDelegate {
            if sd.isFiltering() {
                deck = sd.filteredDecks[indexPath.row]
            }
        }
        
        cell.name.text = deck.name
//        cell.name.isEnabled = false
//        cell.name.autocorrectionType = .no
        //        cell.name.addTarget(self, action: #selector(textChanged(sender:)), for: UIControlEvents.editingChanged)
        //        cell.name.delegate = self
        cell.id = deck.id
        
        //        if selectedObjects.contains(cell.deckId){
        //            cell.alpha = cell.deSelectedAlphaValue
        //        }else{
        //            cell.alpha = cell.selectedAlphaValue
        //        }
        
        cell.indexPath = indexPath
        
        return cell
    }
}




