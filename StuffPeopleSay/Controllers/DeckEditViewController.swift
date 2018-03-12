import UIKit

class DeckEditViewController: UIViewController {
    var deckEditView: DeckEditView!
    var gameStore: GameStore!
    let deckDataSource = DeckCollectionViewDataSource()

//    var filteredDecks = [Deck]()
//    var selectedDecks = [String]()
//    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(DeckEditViewController.newDeck))

        deckEditView = DeckEditView(frame: view.frame)

        deckEditView.collectionView.delegate = self
        view.addSubview(deckEditView)

//        deckDataSource.searchDelegate = self
        deckDataSource.delegate = self
        deckEditView.setDataSource(dataSource: deckDataSource)

//        setupSearch()
    }

    override func viewDidAppear(_ animated: Bool) {
        deckEditView.collectionView.reloadData()
    }

    func setupSearch() {
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//        definesPresentationContext = true
    }

    @objc func newDeck() {
        let alert = UIAlertController(title: "Type in the name of the Deck you'd like to add",
                                      message: nil,
                                      preferredStyle: .alert)

        alert.addTextField(configurationHandler: nil)

        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancel)

        let add = UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            guard let cardText = textField?.text else {return}
            if !cardText.isEmpty {
                self.gameStore.createDeck(name: cardText, completionHandler: { (deck) in
                    if deck != nil {
                        self.deckEditView.collectionView.reloadData()
                        let indexPath = IndexPath(row: self.deckEditView.collectionView.numberOfItems(inSection: 0)-1, section: 0)
                        self.deckEditView.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                    }
                })
            }
        })
        alert.addAction(add)

        present(alert, animated: true, completion: nil)
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
        vc.gameStore = gameStore
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
