import UIKit

protocol SPSCollectionViewControllerDelegate {
    func getCollectionview() -> UICollectionView
    func getCollectionviewBottomConstraint() -> NSLayoutConstraint
}

class SPSCollectionViewController:UIViewController{
    let searchController = UISearchController(searchResultsController: nil)
    var superCollectionView:UICollectionView!
    var superCollectionViewBottomConstraint:NSLayoutConstraint!
    var gameStore:GameStore!
    var filteredDecks = [Deck]()
    var selectedDecks = [String]()
    var SPSDelegate:SPSCollectionViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        superCollectionView = SPSDelegate.getCollectionview()
        superCollectionViewBottomConstraint = SPSDelegate.getCollectionviewBottomConstraint()

        superCollectionView.backgroundColor = UIColor.purple
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Decks"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(SPSCollectionViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SPSCollectionViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    override func viewWillAppear(_ animated: Bool) {
        superCollectionView.reloadData()
    }
}

extension SPSCollectionViewController: UISearchResultsUpdating {
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

extension SPSCollectionViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.superCollectionViewBottomConstraint.constant == 0{
                self.superCollectionViewBottomConstraint.constant += keyboardSize.height// - toolBarView.frame.height
                self.superCollectionView.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.superCollectionViewBottomConstraint.constant != 0{
                self.superCollectionViewBottomConstraint.constant = 0
                self.superCollectionView.layoutIfNeeded()
            }
        }
    }
}

