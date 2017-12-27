//import UIKit
//
//class EditableCollectionView:NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
//    var rightToolBarButton:UIButton!
//    var leftToolBarButton:UIButton!
//    var navigationItem:UINavigationItem!
//    
//    var toolBarState: ToolBarState = .normal
//
//    enum ToolBarState{
//        case normal
//        case editing
//    }
//}
//
//// Tool bar functionality and setup
//extension EditableCollectionView{
//    func toolBarSetup(){
//        switch toolBarState {
//        case .normal:
//            leftToolBarButton.isHidden = true
//            
//            rightToolBarButton.tag = 0
//            rightToolBarButton.setTitle("Add", for: .normal)
//            rightToolBarButton.isEnabled = true
//            
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectBarButton(sender:)))
//            
//        case .editing:
//            leftToolBarButton.tag = 1
//            leftToolBarButton.setTitle("Share", for: .normal)
//            leftToolBarButton.isEnabled = false
//            leftToolBarButton.isHidden = false
//            
//            rightToolBarButton.tag = 2
//            rightToolBarButton.setTitle("Delete", for: .normal)
//            rightToolBarButton.isEnabled = false
//            
//            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:  #selector(cancelBarButton(sender:)))
//        }
//    }
//    
//    @objc func cancelBarButton(sender: UIBarButtonItem) {
//        toolBarState = .normal
//        toolBarSetup()
//        
//        selectedDecks.removeAll()
//        collectionView.reloadData()
//    }
//    
//    @objc func selectBarButton(sender: UIBarButtonItem) {
//        toolBarState = .editing
//        toolBarSetup()
//    }
//    
//    @IBAction func toolBarButtons(sender: UIButton) {
//        if sender.tag == 0{
//            // Add
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "NewDeckViewController") as! NewDeckViewController
//            present(vc, animated: true, completion: nil)
//        } else if sender.tag == 1{
//            // Share
//            print("Add share")
//        }else if sender.tag == 2{
//            // Delete
//            presentDeleteAlert()
//        }
//    }
//    
//    func presentDeleteAlert(){
//        let alert = UIAlertController(title: "Are you sure you want to Delete the \(selectedDecks.count) selected Decks?",
//            message: "This action cannot be undone.",
//            preferredStyle: .actionSheet)
//        
//        let add = UIAlertAction(title: "Delete", style: .default, handler: { (_) in
//            self.deleteSelectedDecks()
//        })
//        alert.addAction(add)
//        
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//        alert.addAction(cancel)
//        
//        present(alert, animated: true, completion: nil)
//    }
//    
//    func deleteSelectedDecks(){
//        for deckId in selectedDecks{
//            if let index = decks.index(where: {$0.deckId == deckId}) {
//                decks.remove(at: index)
//            }
//        }
//        selectedDecks.removeAll()
//        checkToolBarButton()
//        collectionView.reloadData()
//    }
//    
//    func checkToolBarButton(){
//        if selectedDecks.isEmpty{
//            leftToolBarButton.isEnabled = false
//            rightToolBarButton.isEnabled = false
//        }else{
//            leftToolBarButton.isEnabled = false
//            rightToolBarButton.isEnabled = true
//        }
//    }
//}

