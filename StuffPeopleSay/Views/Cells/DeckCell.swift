import UIKit

class DeckCell:SPSCollectionViewCell{    
    let cardsLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardsLabel()
    }
    
    func setupCardsLabel(){
        cardsLabel.font =  UIFont.systemFont(ofSize: 10)
        cardsLabel.textColor = name.textColor
        cardsLabel.textAlignment = .center
        cardsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cardsLabel)

        
        let padding:CGFloat = frame.width * 5/6
        
        let top = NSLayoutConstraint(item: cardsLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: padding)
        top.isActive = true
        
        let bottom = NSLayoutConstraint(item: cardsLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: cardsLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: cardsLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        trailing.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
