import UIKit

class DeckViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    var decks:[Deck]!
    var filteredDecks = [Deck]()
    
    override func viewDidLoad() {
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.backgroundColor = BingoPalette.vanillaBackgroundColor
    }
    @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension DeckViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredDecks = decks.filter({( deck : Deck) -> Bool in
            return deck.name.contains(searchText.lowercased())
        })
        
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if isFiltering() {
            return filteredDecks.count
        }
        
        return decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
        let deck: Deck
        if isFiltering() {
            deck = filteredDecks[indexPath.row]
        } else {
            deck = decks[indexPath.row]
        }
        cell.name.text = deck.name
        return cell
    }
}

extension DeckViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
