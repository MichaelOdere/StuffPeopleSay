import UIKit


enum ToolBarState{
    case normal
    case editing
}

class DeckViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftToolBarButton: UIButton!
    @IBOutlet weak var rightToolBarButton: UIButton!
    
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
        toolBarSetup(state: .normal)

        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.backgroundColor = BingoPalette.vanillaBackgroundColor
    }

    func toolBarSetup(state: ToolBarState){
        switch state {
        case .normal:
            leftToolBarButton.tag = 0
            leftToolBarButton.titleLabel?.text = "Edit"
            
            rightToolBarButton.tag = 1
            rightToolBarButton.titleLabel?.text = "Add"

            navigationItem.rightBarButtonItem = nil
        case .editing:
            leftToolBarButton.tag = 2
            leftToolBarButton.titleLabel?.text = "Share"
            
            rightToolBarButton.tag = 3
            rightToolBarButton.titleLabel?.text = "Delete"
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:  #selector(cancelBarButton(sender:)))

        }
    }
    
    @objc func cancelBarButton(sender: UIBarButtonItem) {
        toolBarSetup(state: .normal)
        
        print("Cancel")
    }
    
    @IBAction func toolBarButtons(sender: UIButton) {
        if sender.tag == 0{
            toolBarSetup(state: .editing)

            print("edit logic")
        }else if sender.tag == 1{
            print("Add logic")
        } else if sender.tag == 2{
            print("Add share")
        }else if sender.tag == 3{
            print("Add del")
        }
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
