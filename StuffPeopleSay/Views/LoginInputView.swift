import UIKit

class LoginInputView: UIView {
    var imageView = UIImageView()
    var borderLabel = UILabel()
    var textField = UITextField()

    var verticlePadding:CGFloat = 1
    var horizontalPadding:CGFloat = 1
    var height:CGFloat = 30

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white.withAlphaComponent(0.2)

        self.addSubview(imageView)
        self.addSubview(borderLabel)
        self.addSubview(textField)
        
        setupImageView()
        setupBorderLabel()
        setupTextField()
    }
    
    func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        let top = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: verticlePadding)
        top.isActive = true
        
        let bottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -verticlePadding)
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
        
        let height = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.height)
        height.isActive = true
        
        let aspect = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0)
        aspect.isActive = true
    }
    
    func setupBorderLabel() {
        borderLabel.backgroundColor = UIColor.black
        borderLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: borderLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: verticlePadding+1)
        top.isActive = true
        
        let bottom = NSLayoutConstraint(item: borderLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -(verticlePadding+1))
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: borderLabel, attribute: .leading, relatedBy: .equal, toItem: imageView, attribute: .trailing, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
        
        let width = NSLayoutConstraint(item: borderLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 1)
        width.isActive = true
  }
    
    func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        textField.textColor = UIColor.white
        
        let top = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: verticlePadding)
        top.isActive = true
        
        let bottom = NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -verticlePadding)
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: borderLabel, attribute: .trailing, multiplier: 1, constant: 4 * horizontalPadding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
