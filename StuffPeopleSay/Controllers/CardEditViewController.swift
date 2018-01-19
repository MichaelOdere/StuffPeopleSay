import UIKit

class CardEditViewController: UIViewController{
    var cardEditView:CardEditView!
    var gameStore:GameStore!
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
        cardDataSource.delegate = self
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

extension CardEditViewController: CardCollectionViewDelegate {
    var d: Deck {
        return deck
    }
    
    var cardView: CardEditView {
        return cardEditView
    }
}

extension CardEditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        cell.cellSelected()

        if let index = deck.cards.index(where: {$0.id == cell.id}) {
            deck.cards[index].active = cell.state == .selected
        
            if deck.cards[index].active {
                gameStore.addCards(deckId: deck.id, cards: [deck.cards[index].id], completionHandler: { (success) in
                    print("Card added")
                })
            }else{
                gameStore.removeCards(deckId: deck.id, cards: [deck.cards[index].id], completionHandler: { (success) in
                    print("Card removed")
                })
            }
        }
    }
}
//        if let index = decks.index(where: {$0.id == deckId}) {
//            return decks[index]
//        }
//        return nil
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
