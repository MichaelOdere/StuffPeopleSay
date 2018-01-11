import UIKit

class DeckEditViewController: UIViewController{
    var gameStore:GameStore!
    var filteredDecks = [Deck]()
    var selectedDecks = [String]()
    let deckDataSource = DeckCollectionViewDataSource()

//    let searchController = UISearchController(searchResultsController: nil)
    var deckEditView:DeckEditView!

    override func viewDidLoad() {
        super.viewDidLoad()

        deckEditView = DeckEditView(frame: view.frame)
        deckEditView.collectionView.delegate = self
        view.addSubview(deckEditView)
        
        deckDataSource.gameStore = gameStore
//        deckDataSource.searchDelegate = self
        deckEditView.setDataSource(deckDataSource: deckDataSource)
        
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//        definesPresentationContext = true
    }
}

extension DeckEditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CardEditViewController") as! CardEditViewController
        vc.deck = gameStore.decks[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//extension DeckEditViewController: UISearchResultsUpdating, DeckSearchCollectionViewDelegate{
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
//            return deck.name.lowercased().contains(searchText.lowercased())
//        })
//        deckEditView.collectionView.reloadData()
//    }
//}






