import UIKit

class DeckEditViewController: UIViewController{
    var deckEditView:DeckEditView!
    var gameStore:GameStore!
    let deckDataSource = DeckCollectionViewDataSource()

//    var filteredDecks = [Deck]()
//    var selectedDecks = [String]()
//    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        deckEditView = DeckEditView(frame: view.frame)
        deckEditView.collectionView.delegate = self
        view.addSubview(deckEditView)
        
//        deckDataSource.searchDelegate = self
        deckDataSource.delegate = self
        deckEditView.setDataSource(dataSource: deckDataSource)
        
        setupSearch()
    }
    
    func setupSearch(){
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//        definesPresentationContext = true
    }
}

extension DeckEditViewController: DeckCollectionViewDelegate {
    var gs: GameStore {
        return gameStore
    }

    var deckView: DeckEditView {
        return deckEditView
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
