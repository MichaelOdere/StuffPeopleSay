import UIKit

protocol CollectionViewType: class {
    func getCollectionView() -> UICollectionView
}

class EditView: UIView {
    var collectionView: UICollectionView!
    var bottomCollectionLayoutConstraint: NSLayoutConstraint!
    weak var collectionViewTypeDelegate: CollectionViewType? {
        didSet {
            setupCollectionView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(EditView.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditView.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCollectionView() {
        collectionView = collectionViewTypeDelegate?.getCollectionView()

        self.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        top.isActive = true
        bottomCollectionLayoutConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        bottomCollectionLayoutConstraint.isActive = true
        let trailing = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        trailing.isActive = true
        let leading = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leading.isActive = true
    }

    func setDataSource(dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
}

extension EditView {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if bottomCollectionLayoutConstraint.constant == 0 {
                bottomCollectionLayoutConstraint.constant += keyboardSize.height
                collectionView.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if bottomCollectionLayoutConstraint.constant != 0 {
                bottomCollectionLayoutConstraint.constant = 0
                collectionView.layoutIfNeeded()
            }
        }
    }
//    
//    @objc func textChanged(sender: UITextField){
//        collectionViewControllerDelegate?.getTextChanged(sender: sender)
//    }
}

extension EditView: UITextFieldDelegate {
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        isEditingATextField = true
    //    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isEnabled = false
        //        isEditingATextField = false
    }
}
