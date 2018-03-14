import UIKit

class HomeViewController: UIViewController {
    var loginViewController = LoginViewController()
    var signUpViewController = SignUpViewController()
    var gameStore: GameStore!
    var iconImageView: UIImageView = UIImageView()
    let loginButton: UIButton = HomeButton(type: .system)
    let signUpButton: UIButton = HomeButton(type: .system)

    var horizontalPadding: CGFloat!

    override func viewDidLoad() {
        horizontalPadding = view.frame.width * 0.05
        view.backgroundColor = BingoPalette.bingoCellBackgroundColor
        setupIconImage()
        setupLoginButton()
        setupSignUpButton()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setupIconImage() {
        view.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        iconImageView.image = UIImage(named: "login-person2")
        iconImageView.contentMode = .scaleAspectFit

        let centerY = NSLayoutConstraint(item: iconImageView,
                                     attribute: NSLayoutAttribute.centerY,
                                     relatedBy: NSLayoutRelation.equal,
                                     toItem: self.view,
                                     attribute: NSLayoutAttribute.centerY,
                                     multiplier: 1,
                                     constant: 0)
        centerY.isActive = true

        let leading = NSLayoutConstraint(item: iconImageView,
                                         attribute: NSLayoutAttribute.leading,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self.view,
                                         attribute: NSLayoutAttribute.leading,
                                         multiplier: 1,
                                         constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: iconImageView,
                                         attribute: NSLayoutAttribute.trailing,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self.view,
                                         attribute: NSLayoutAttribute.trailing,
                                         multiplier: 1,
                                         constant: -horizontalPadding)
        trailing.isActive = true

        let height = NSLayoutConstraint(item: iconImageView,
                                          attribute: NSLayoutAttribute.height,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: nil,
                                          attribute: NSLayoutAttribute.height,
                                          multiplier: 1,
                                          constant: view.frame.height * 0.25)
        height.isActive = true

    }

    func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        loginButton.addTarget(self, action: #selector(HomeViewController.showLoginViewController), for: .touchUpInside)

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

    @objc func showLoginViewController() {
        loginViewController.gameStore = gameStore
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }

    func setupSignUpButton() {
        signUpButton.setTitle("Sign Up", for: .normal)
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(HomeViewController.showSignUpViewController), for: .touchUpInside)

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

    @objc func showSignUpViewController() {
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
