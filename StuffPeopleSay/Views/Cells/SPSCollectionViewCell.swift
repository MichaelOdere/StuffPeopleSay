import UIKit

enum SelectedState {
    case selected
    case deselected
}

class SPSCollectionViewCell:UICollectionViewCell{
    var name: CardTextfield!
    var deSelectedAlphaValue:CGFloat = 0.5
    var selectedAlphaValue:CGFloat = 1.0
    var hasBeenSelected:Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNameTextfield(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNameTextfield(frame: self.frame)
    }
    
    func setupNameTextfield(frame: CGRect){
        name = CardTextfield(frame: frame)
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
