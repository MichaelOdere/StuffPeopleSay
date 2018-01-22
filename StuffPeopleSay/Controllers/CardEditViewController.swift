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
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action:  #selector(CardEditViewController.newCard))

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
    
    @objc func newCard() {
        let alert = UIAlertController(title: "Type in the name of the Card you'd like to add",
                                      message: nil,
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancel)
        
        let add = UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            guard let cardText = textField?.text else {return}
            if !cardText.isEmpty{
                self.gameStore.createCard(name: cardText, completionHandler: { (card) in
                    if card != nil {
                        self.cardEditView.collectionView.reloadData()
                        let indexPath = IndexPath(row: self.cardEditView.collectionView.numberOfItems(inSection: 0)-1, section: 0)
                        self.cardEditView.collectionView.scrollToItem(at:indexPath, at: .bottom, animated: true)
                    }
                })
            }
        })
        alert.addAction(add)
        
        present(alert, animated: true, completion: nil)
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
