import UIKit

class DeckCell:SPSCollectionViewCell{    
    let cardsLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardsLabel()
    }
    
    func setupCardsLabel(){
        cardsLabel.font =  UIFont.systemFont(ofSize: 10)
        cardsLabel.textColor = UIColor.gray
        cardsLabel.textAlignment = .right
        cardsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cardsLabel)

        
        let padding:CGFloat = frame.width * 3/4
        
        let height = NSLayoutConstraint(item: cardsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 16)
        height.isActive = true
        
        let bottom = NSLayoutConstraint(item: cardsLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -2)
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: cardsLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: cardsLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -2)
        trailing.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
