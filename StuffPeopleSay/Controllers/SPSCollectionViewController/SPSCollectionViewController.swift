import UIKit

protocol SPSCollectionViewControllerDelegate {
    func getCollectionview() -> UICollectionView
    func getCollectionviewBottomConstraint() -> NSLayoutConstraint
    func getTextChanged(sender: UITextField)
}

class SPSCollectionViewController:UIViewController{
    var superCollectionView:UICollectionView!
    var superCollectionViewBottomConstraint:NSLayoutConstraint!

    var gameStore:GameStore!
    var collectionViewControllerDelegate:SPSCollectionViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        superCollectionView = collectionViewControllerDelegate.getCollectionview()
        superCollectionViewBottomConstraint = collectionViewControllerDelegate.getCollectionviewBottomConstraint()

        NotificationCenter.default.addObserver(self, selector: #selector(SPSCollectionViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SPSCollectionViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        superCollectionView.reloadData()
    }
}

extension SPSCollectionViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.superCollectionViewBottomConstraint.constant == 0{
                var displacement:CGFloat = 0
                if let h = navigationController?.navigationBar.frame.height {
                    displacement += h
                }
                self.superCollectionViewBottomConstraint.constant += keyboardSize.height - displacement
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
    
    @objc func textChanged(sender: UITextField){
        collectionViewControllerDelegate.getTextChanged(sender: sender)
    }
}

