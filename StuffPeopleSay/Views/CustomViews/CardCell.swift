import UIKit

class CardCell:UICollectionViewCell{
    var name: CardTextfield!
    var boardCardId:String!
    var indexPath:IndexPath!
    
    var hasBeenSelected:Bool = false
    var deSelectedAlphaValue:CGFloat = 1.0
    var selectedAlphaValue:CGFloat = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupNameTextfield(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
        setupNameTextfield(frame: self.frame)
    }
    
    func setupNameTextfield(frame: CGRect){
        name = CardTextfield(frame: frame)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(name)
                
        let top = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        top.isActive = true
        let bottom = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        bottom.isActive = true
        let trailing = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        trailing.isActive = true
        let leading = NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leading.isActive = true
    }
}

