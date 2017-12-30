//import UIKit
//
//class DeckCollectionView:NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
//    var gameStore:GameStore!
//    var filteredDecks = [Deck]()
//
//    var didSelectRow: ((_ card: Card, _ cell: BingoCollectionCell ) -> Void)?
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if isFiltering() {
//            return filteredDecks.count
//        }
//        return gameStore.decks.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
//        let deck: Deck
//        if isFiltering() {
//            deck = filteredDecks[indexPath.row]
//        } else {
//            deck = gameStore.decks[indexPath.row]
//        }
//        cell.name.text = deck.name
//        cell.deckId = deck.deckId
//
//        if selectedDecks.contains(cell.deckId){
//            cell.alpha = cell.selectedAlphaValue
//        }else{
//            cell.alpha = cell.deSelectedAlphaValue
//        }
//
//        return cell
//    }
//}
//
//extension DeckCollectionView: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//
//    func isFiltering() -> Bool {
//        return searchController.isActive && !searchBarIsEmpty()
//    }
//
//    func searchBarIsEmpty() -> Bool {
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredDecks = gameStore.decks.filter({( deck : Deck) -> Bool in
//            return deck.name.contains(searchText.lowercased())
//        })
//        collectionView.reloadData()
//    }
//}
//
//
