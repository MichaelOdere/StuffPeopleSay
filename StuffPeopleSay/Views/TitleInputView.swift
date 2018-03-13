import UIKit

class TitleInputView: UIView {
    let titleLabel: UILabel = UILabel()
    let textField: UITextField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
        setupTextField()
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: titleLabel,
                                     attribute: NSLayoutAttribute.top,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: self,
                                     attribute: NSLayoutAttribute.top,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let trailing = NSLayoutConstraint(item: titleLabel,
                                          attribute: NSLayoutAttribute.trailing,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: self,
                                          attribute: NSLayoutAttribute.trailing,
                                          multiplier: 1,
                                          constant: 0)
        trailing.isActive = true

        let leading = NSLayoutConstraint(item: titleLabel,
                                         attribute: NSLayoutAttribute.leading,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self,
                                         attribute: NSLayoutAttribute.leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true
    }

    func setupTextField() {
        addSubview(textField)
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 2
        textField.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: textField,
                                     attribute: NSLayoutAttribute.top,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: titleLabel,
                                     attribute: NSLayoutAttribute.bottom,
                                     multiplier: 1,
                                     constant: 0)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: textField,
                                     attribute: NSLayoutAttribute.bottom,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: self,
                                     attribute: NSLayoutAttribute.bottom,
                                     multiplier: 1,
                                     constant: 0)
        bottom.isActive = true

        let trailing = NSLayoutConstraint(item: textField,
                                          attribute: NSLayoutAttribute.trailing,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: self,
                                          attribute: NSLayoutAttribute.trailing,
                                          multiplier: 1,
                                          constant: 0)
        trailing.isActive = true

        let leading = NSLayoutConstraint(item: textField,
                                         attribute: NSLayoutAttribute.leading,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self,
                                         attribute: NSLayoutAttribute.leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let height = NSLayoutConstraint(item: textField,
                                        attribute: NSLayoutAttribute.bottom,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: titleLabel,
                                        attribute: NSLayoutAttribute.bottom,
                                        multiplier: 4,
                                        constant: 0)
        height.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
