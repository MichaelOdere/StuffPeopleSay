import UIKit

class HomeViewController: UIViewController {
    var iconImage: UIImage = UIImage()
    var loginButton: UIButton = HomeButton(type: .system)
    var signUpButton: UIButton = HomeButton(type: .system)

    var horizontalPadding: CGFloat!

    override func viewDidLoad() {
        horizontalPadding = view.frame.width * 0.05
        view.backgroundColor = BingoPalette.bingoCellBackgroundColor
        setupLoginButton()
        setupSignUpButton()
    }

    func setupIconImage() {

    }

    func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        let leading = NSLayoutConstraint(item: loginButton,
                                         attribute: NSLayoutAttribute.leading,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self.view,
                                         attribute: NSLayoutAttribute.leading,
                                         multiplier: 1,
                                         constant: horizontalPadding)
        leading.isActive = true

        let bottom = NSLayoutConstraint(item: loginButton,
                                          attribute: NSLayoutAttribute.bottom,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: self.view,
                                          attribute: NSLayoutAttribute.bottom,
                                          multiplier: 1,
                                          constant: -horizontalPadding)
        bottom.isActive = true
    }

    func setupSignUpButton() {
        signUpButton.setTitle("Sign Up", for: .normal)
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false

        let trailing = NSLayoutConstraint(item: signUpButton,
                                          attribute: NSLayoutAttribute.trailing,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: self.view,
                                          attribute: NSLayoutAttribute.trailing,
                                          multiplier: 1,
                                          constant: -horizontalPadding)
        trailing.isActive = true

        let bottom = NSLayoutConstraint(item: signUpButton,
                                        attribute: NSLayoutAttribute.bottom,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: self.view,
                                        attribute: NSLayoutAttribute.bottom,
                                        multiplier: 1,
                                        constant: -horizontalPadding)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: signUpButton,
                                         attribute: NSLayoutAttribute.leading,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: loginButton,
                                         attribute: NSLayoutAttribute.trailing,
                                         multiplier: 1,
                                         constant: horizontalPadding)
        leading.isActive = true

        let equalHeight = NSLayoutConstraint(item: signUpButton,
                                        attribute: NSLayoutAttribute.height,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: loginButton,
                                        attribute: NSLayoutAttribute.height,
                                        multiplier: 1,
                                        constant: 0)
        equalHeight.isActive = true

        let height = NSLayoutConstraint(item: signUpButton,
                                        attribute: NSLayoutAttribute.height,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: nil,
                                        attribute: NSLayoutAttribute.height,
                                        multiplier: 1,
                                        constant: self.view.frame.height * 0.07)
        height.isActive = true

        let width = NSLayoutConstraint(item: signUpButton,
                                        attribute: NSLayoutAttribute.width,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: loginButton,
                                        attribute: NSLayoutAttribute.width,
                                        multiplier: 1,
                                        constant: 0)
        width.isActive = true

    }
}
