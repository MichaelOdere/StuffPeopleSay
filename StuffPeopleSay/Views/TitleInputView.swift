import UIKit

class TitleInputView: UIView {
    let titleLabel: UILabel = UILabel()
    let textFieldView: UIView = UIView()
    let textField: UITextField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
        setupTextFieldView()
        setupTextField()
    }

    func setupTitleLabel() {
        titleLabel.adjustsFontSizeToFitWidth = true
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

    func setupTextFieldView() {
        addSubview(textFieldView)
        textFieldView.backgroundColor = UIColor.white
        textFieldView.layer.borderColor = UIColor.lightGray.cgColor
        textFieldView.layer.borderWidth = 1
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.layer.cornerRadius = 6
        textFieldView.layer.masksToBounds = false
        textFieldView.layer.shadowColor = UIColor.blue.cgColor
        textFieldView.layer.shadowOffset = CGSize.zero
        textFieldView.layer.shadowOpacity = 0.0
        textFieldView.layer.shadowRadius = 4

        let top = NSLayoutConstraint(item: textFieldView,
                                     attribute: NSLayoutAttribute.top,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: titleLabel,
                                     attribute: NSLayoutAttribute.bottom,
                                     multiplier: 1,
                                     constant: 6)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: textFieldView,
                                     attribute: NSLayoutAttribute.bottom,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: self,
                                     attribute: NSLayoutAttribute.bottom,
                                     multiplier: 1,
                                     constant: 0)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: textFieldView,
                                         attribute: NSLayoutAttribute.leading,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self,
                                         attribute: NSLayoutAttribute.leading,
                                         multiplier: 1,
                                         constant: 0)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: textFieldView,
                                          attribute: NSLayoutAttribute.trailing,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: self,
                                          attribute: NSLayoutAttribute.trailing,
                                          multiplier: 1,
                                          constant: 0)
        trailing.isActive = true

        let height = NSLayoutConstraint(item: textFieldView,
                                        attribute: NSLayoutAttribute.bottom,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: titleLabel,
                                        attribute: NSLayoutAttribute.bottom,
                                        multiplier: 4,
                                        constant: 0)
        height.isActive = true
    }

    func setupTextField() {
        textFieldView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 6.0

        let top = NSLayoutConstraint(item: textField,
                                     attribute: NSLayoutAttribute.top,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: textFieldView,
                                     attribute: NSLayoutAttribute.top,
                                     multiplier: 1,
                                     constant: padding)
        top.isActive = true

        let bottom = NSLayoutConstraint(item: textField,
                                        attribute: NSLayoutAttribute.bottom,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: textFieldView,
                                        attribute: NSLayoutAttribute.bottom,
                                        multiplier: 1,
                                        constant: -padding)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: textField,
                                         attribute: NSLayoutAttribute.leading,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: textFieldView,
                                         attribute: NSLayoutAttribute.leading,
                                         multiplier: 1,
                                         constant: padding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: textField,
                                          attribute: NSLayoutAttribute.trailing,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: textFieldView,
                                          attribute: NSLayoutAttribute.trailing,
                                          multiplier: 1,
                                          constant: -padding)
        trailing.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
