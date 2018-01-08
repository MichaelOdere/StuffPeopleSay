import UIKit

protocol SPSSearchCollectionViewControllerDelegate {
    func getFilteredObjectsFromSearchText(name:String)->[SearchableObject]
}

class SPSSearchCollectionViewController: SPSCollectionViewController {
    var filteredObjects = [SearchableObject]()
    var selectedObjects = [String]()
    var searchDelegate:SPSSearchCollectionViewControllerDelegate!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension SPSSearchCollectionViewController: UISearchResultsUpdating {
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
        filteredObjects = searchDelegate.getFilteredObjectsFromSearchText(name: searchText)
        superCollectionView.reloadData()
    }
}
