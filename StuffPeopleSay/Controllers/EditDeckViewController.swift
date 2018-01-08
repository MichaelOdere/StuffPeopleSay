import UIKit

class EditDeckViewController:SPSCollectionViewController{
    enum ToolBarState {
        case normal
        case editing
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftToolBarButton: UIButton!
    @IBOutlet weak var rightToolBarButton: UIButton!
    @IBOutlet weak var collectionViewBottomLayoutConstraint: NSLayoutConstraint!
    
    var toolBarState: ToolBarState = .normal {
        didSet {
            toolBarSetup()
        }
    }
    
    override func viewDidLoad() {
        SPSDelegate = self
        
        super.viewDidLoad()
        
        rightToolBarButton.addTarget(self, action: #selector(toolBarButtons(sender:)), for: .touchUpInside)
        leftToolBarButton.addTarget(self, action: #selector(toolBarButtons(sender:)), for: .touchUpInside)
        
        toolBarSetup()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = BingoPalette.vanillaBackgroundColor
        
        let lpgr = UILongPressGestureRecognizer(target: self, action:  #selector(EditDeckViewController.handleLongPress(gestureReconizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true

        self.collectionView.addGestureRecognizer(lpgr)

    }
}

extension EditDeckViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredDecks.count
        }
        return gameStore.decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DeckCell
        if toolBarState == .editing{
            if selectedDecks.contains(cell.deckId){
                cell.alpha = cell.deSelectedAlphaValue
                if let index = selectedDecks.index(of: cell.deckId) {
                    selectedDecks.remove(at: index)
                }
            }else{
                cell.alpha = cell.selectedAlphaValue
                selectedDecks.append(cell.deckId)
            }
            checkToolBarButton()
        }else{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CardsViewController") as! CardsViewController
            vc.gameStore = gameStore
            vc.deck = gameStore.decks[indexPath.row]
            vc.newDeck = false
            present(vc, animated: true, completion: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCell", for: indexPath) as! DeckCell
        let deck: Deck
        if isFiltering() {
            deck = filteredDecks[indexPath.row]
        } else {
            deck = gameStore.decks[indexPath.row]
        }
        cell.name.text = deck.name
        cell.name.isEnabled = false
        cell.deckId = deck.id
        
        if selectedDecks.contains(cell.deckId){
            cell.alpha = cell.selectedAlphaValue
        }else{
            cell.alpha = cell.deSelectedAlphaValue
        }
        
        cell.indexPath = indexPath
        
        return cell
    }
}

// Tool bar functionality and setup
extension EditDeckViewController{
    func toolBarSetup(){
        switch toolBarState {
        case .normal:
            leftToolBarButton.isHidden = true
            
            rightToolBarButton.tag = 0
            rightToolBarButton.setTitle("Add", for: .normal)
            rightToolBarButton.isEnabled = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectBarButton(sender:)))
            
        case .editing:
            leftToolBarButton.tag = 1
            leftToolBarButton.setTitle("Share", for: .normal)
            leftToolBarButton.isEnabled = false
            leftToolBarButton.isHidden = false
            
            rightToolBarButton.tag = 2
            rightToolBarButton.setTitle("Delete", for: .normal)
            rightToolBarButton.isEnabled = false
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:  #selector(cancelBarButton(sender:)))
        }
    }
    
    @objc func cancelBarButton(sender: UIBarButtonItem) {
        toolBarState = .normal
        selectedDecks.removeAll()
        collectionView.reloadData()
    }
    
    @objc func selectBarButton(sender: UIBarButtonItem) {
        toolBarState = .editing
        collectionView.reloadData()
    }
    
    @objc func toolBarButtons(sender: UIButton) {
        if sender.tag == 0{
            // Add
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CardsViewController") as! CardsViewController
            vc.gameStore = gameStore
            vc.deck = Deck(id: "", name: "", cards: emptyCards())
            vc.newDeck = true
            present(vc, animated: true, completion: nil)
        } else if sender.tag == 1{
            // Share
            print("Add share")
        }else if sender.tag == 2{
            // Delete
            presentDeleteAlert()
        }
    }
    
    func emptyCards()->[Card]{
        var allCards:[Card] = []
        for index in 0..<25{
            allCards.append(Card(id: "", name: "", active: 0, order: index))
        }
        return allCards
    }
    
    func presentDeleteAlert(){
        let alert = UIAlertController(title: "Are you sure you want to Delete the \(selectedDecks.count) selected Decks?",
            message: "This action cannot be undone.",
            preferredStyle: .actionSheet)
        
        let add = UIAlertAction(title: "Delete", style: .default, handler: { (_) in
            self.deleteSelectedDecks()
            self.toolBarState = .normal
        })
        alert.addAction(add)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteSelectedDecks(){
        for id in selectedDecks{
            if let index = gameStore.decks.index(where: {$0.id == id}) {
                gameStore.decks.remove(at: index)
            }
        }
        selectedDecks.removeAll()
        checkToolBarButton()
        collectionView.reloadData()
    }
    
    func checkToolBarButton(){
        if selectedDecks.isEmpty{
            leftToolBarButton.isEnabled = false
            rightToolBarButton.isEnabled = false
        }else{
            leftToolBarButton.isEnabled = false
            rightToolBarButton.isEnabled = true
        }
    }
}

extension EditDeckViewController {
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        let p = gestureReconizer.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            var cell = self.collectionView.cellForItem(at: index) as! DeckCell
            cell.name.isEnabled = true
            cell.name.becomeFirstResponder()
        } else {
            print("Could not find index path")
        }
    }
}

extension EditDeckViewController:SPSCollectionViewControllerDelegate {
    func getCollectionview() -> UICollectionView {
        return collectionView
    }
    
    func getCollectionviewBottomConstraint() -> NSLayoutConstraint {
        return collectionViewBottomLayoutConstraint
    }
    
    func getTextChanged(sender:UITextField) {
        print("TEXT CHANGED!")
    }
}

