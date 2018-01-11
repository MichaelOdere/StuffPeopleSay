import UIKit

protocol CollectionViewType: class {
    func getCollectionView() -> UICollectionView
}

class EditView: UIView{
    var collectionView: UICollectionView!
    var bottomCollectionLayoutConstraint:NSLayoutConstraint!
    weak var collectionViewTypeDelegate:CollectionViewType? {
        didSet {
            setupCollectionView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView(){
        collectionView = collectionViewTypeDelegate?.getCollectionView()

        self.addSubview(collectionView)
        
        let top = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        top.isActive = true
        let bottomCollectionLayoutConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        bottomCollectionLayoutConstraint.isActive = true
        let trailing = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        trailing.isActive = true
        let leading = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leading.isActive = true
    }
}
