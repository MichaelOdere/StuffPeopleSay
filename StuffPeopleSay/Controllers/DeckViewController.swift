import UIKit

class DeckViewController:UIViewController{
    let searchController = UISearchController(searchResultsController: nil)
    var superCollectionView:UICollectionView!
    var gameStore:GameStore!
    var filteredDecks = [Deck]()
    var selectedDecks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        superCollectionView.backgroundColor = UIColor.purple
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Decks"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    override func viewWillAppear(_ animated: Bool) {
        superCollectionView.reloadData()
    }
}

extension DeckViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredDecks = gameStore.decks.filter({( deck : Deck) -> Bool in
            return deck.name.lowercased().contains(searchText.lowercased())
        })
        superCollectionView.reloadData()
    }
}

