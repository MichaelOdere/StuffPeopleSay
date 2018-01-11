import UIKit

protocol DeckSearchCollectionViewDelegate: class {
    func isFiltering()->Bool
    var filteredDecks:[Deck] { get }
    //    var selectedDecks:[String] { get }
}

protocol DeckCollectionViewDelegate: class {
    var gs:GameStore { get }
    var deckView:DeckEditView { get }
}

class DeckCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    weak var delegate:DeckCollectionViewDelegate?
    weak var searchDelegate:DeckSearchCollectionViewDelegate?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sd = searchDelegate {
            if sd.isFiltering(){
                return searchDelegate!.filteredDecks.count
            }
        }
        if let delegate = delegate {
            return delegate.gs.decks.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
        var deck = delegate?.gs.decks[indexPath.row]
        
        if let sd = searchDelegate {
            if sd.isFiltering() {
                deck = sd.filteredDecks[indexPath.row]
            }
        }
        
        cell.name.text = deck?.name
        cell.name.delegate = delegate?.deckView
        cell.id = deck?.id
        
//        if selectedObjects.contains(cell.deckId){
//            cell.alpha = cell.deSelectedAlphaValue
//        }else{
//            cell.alpha = cell.selectedAlphaValue
//        }
        
        cell.indexPath = indexPath
        
        return cell
    }
}




