import UIKit

class CardEditViewController: UIViewController{
    var cardEditView:CardEditView!
    var deck:Deck!
    let cardDataSource = CardCollectionViewDataSource()

    var filteredCards = [Card]()
    var selectedCards = [String]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardEditView = CardEditView(frame: view.frame)
        cardEditView.collectionView.delegate = self
        view.addSubview(cardEditView)

//        cardDataSource.searchDelegate = self
        cardDataSource.deck = deck
        cardEditView.setDataSource(dataSource: cardDataSource)
        
//        setupSearch()
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

extension CardEditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

//extension CardEditViewController: UISearchResultsUpdating, CardSearchCollectionViewDelegate{
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
//        filteredCards = deck.cards.filter({( card : Card) -> Bool in
//            return card.name.lowercased().contains(searchText.lowercased())
//        })
//        cardEditView.collectionView.reloadData()
//    }
//}
//
//
