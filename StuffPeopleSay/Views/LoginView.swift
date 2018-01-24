import UIKit

enum ButtonState{
    case active
    case inactive
}

class LoginView: UIView {
    var loginButton = UIButton()
    var emailTextField = LoginInputView()
    var passwordTextField = LoginInputView()

    var verticlePadding:CGFloat = 10
    var horizontalPadding:CGFloat = 50

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.flatBlue()
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)

        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
    }
    
    func setupEmailTextField() {
//        emailTextField.imageView.image = UIImage(named: "login-person")
        emailTextField.backgroundColor = UIColor.white
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let bottom = NSLayoutConstraint(item: emailTextField, attribute: .bottom, relatedBy: .equal, toItem: passwordTextField, attribute: .top, multiplier: 1, constant: -verticlePadding)
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: emailTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: emailTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
    }
    
    func setupPasswordTextField() {
//        emailTextField.imageView.image = UIImage(named: "login-lock")
        passwordTextField.backgroundColor = UIColor.flatPink()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let centerY = NSLayoutConstraint(item: passwordTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        centerY.isActive = true
        
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: emailTextField, attribute: .height, multiplier: 1, constant: 0)
        height.isActive = true
    }
    
    func setupLoginButton() {
        loginButton.backgroundColor = UIColor.flatBrown()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1, constant: verticlePadding)
        top.isActive = true
        
        let leading = NSLayoutConstraint(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: loginButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
        
        let height = NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: passwordTextField, attribute: .height, multiplier: 1, constant: 0)
        height.isActive = true
    }
//    func updateEmailTextField(){
//        if gameStore.keychain.get("email") != nil{
//            print("here is email ", gameStore.keychain.get("email"))
//            emailTextField.text = gameStore.keychain.get("email")
//            configureButton(for: .active)
//        }else{
//            configureButton(for: .inactive)
//        }
//    }
//
//    func configureButton(for state: ButtonState){
//        switch state{
//        case .active:
//            self.loginButton.alpha = 1.0
//            self.loginButton.isEnabled = true
//        case .inactive:
//            self.loginButton.alpha = 0.6
//            self.loginButton.isEnabled = false
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
