import UIKit

protocol SPSCollectionViewControllerDelegate {
    func getCollectionview() -> UICollectionView
    func getCollectionviewBottomConstraint() -> NSLayoutConstraint
    func getTextChanged(sender: UITextField)
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
            
            var displacement:CGFloat = 0
            
            if let h = navigationController?.navigationBar.frame.height {
                displacement += h
            }
            
            print("displacement, \(displacement)")
            if self.superCollectionViewBottomConstraint.constant == 0{
                self.superCollectionViewBottomConstraint.constant += keyboardSize.height - displacement
                self.superCollectionView.layoutIfNeeded()
                
                if let last = self.superCollectionView.visibleCells.last as? DeckCell{
                    print("scroll!")
                    print(last.indexPath)
                    self.superCollectionView.scrollToItem(at: IndexPath(item: 3, section: 0), at: .bottom, animated: true)
                }else{
                    print("No scroll")
                }
                
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
    
    @objc func textChanged(sender: UITextField){
        SPSDelegate.getTextChanged(sender: sender)
    }
}

extension SPSCollectionViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
