import UIKit

enum ButtonState{
    case active
    case inactive
}

class LoginView: UIView {
    var logoView = UIImageView()
    var loginButton = UIButton()
    var emailTextField = LoginInputView()
    var passwordTextField = LoginInputView()
    
    var verticlePadding:CGFloat = 10
    var horizontalPadding:CGFloat = 50

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(logoView)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)

        setupLogoView()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        
        // tap to remove keyboard
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:))))
    }
    
    func setupLogoView() {
        logoView.image  = UIImage(named: "login-person")
        logoView.contentMode = .scaleAspectFit
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottom = NSLayoutConstraint(item: logoView, attribute: .bottom, relatedBy: .equal, toItem: emailTextField, attribute: .top, multiplier: 1, constant: -3 * verticlePadding)
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: logoView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: logoView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
        
        let height = NSLayoutConstraint(item: logoView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
        height.isActive = true
    }
    
    func setupEmailTextField() {
        emailTextField.imageView.image = UIImage(named: "login-person")
        emailTextField.textField.placeholder = "Email"
        emailTextField.textField.delegate = self
        emailTextField.textField.addTarget(self, action: #selector(LoginView.textFieldDidChange(_:)),
                                           for: UIControlEvents.editingChanged)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let bottom = NSLayoutConstraint(item: emailTextField, attribute: .bottom, relatedBy: .equal, toItem: passwordTextField, attribute: .top, multiplier: 1, constant: -verticlePadding)
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: emailTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: emailTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
    }
    
    func setupPasswordTextField() {
        passwordTextField.imageView.image = UIImage(named: "login-lock")
        passwordTextField.textField.placeholder = "Password"
        passwordTextField.textField.isSecureTextEntry = true
        passwordTextField.textField.delegate = self
        passwordTextField.textField.addTarget(self, action: #selector(LoginView.textFieldDidChange(_:)),
                                              for: UIControlEvents.editingChanged)

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
        loginButton.adjustsImageWhenHighlighted = true
        loginButton.backgroundColor = BingoPalette.vanillaBackgroundColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.blue, for: .selected)
        loginButton.setTitleColor(UIColor.flatPink(), for: .normal)
        loginButton.isSelected = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        configureButton(for: .inactive)
        
        let top = NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1, constant: verticlePadding * 1.5)
        top.isActive = true
        
        let leading = NSLayoutConstraint(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: loginButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
        
        let height = NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: passwordTextField, attribute: .height, multiplier: 1, constant: 0)
        height.isActive = true
    }
  
    @objc func textFieldDidChange(_ textField: UITextField) {
        if areTextFieldsEmpty(){
            configureButton(for: .inactive)
        }else{
            configureButton(for: .active)
        }
    }

    func configureButton(for state: ButtonState){
        switch state{
        case .active:
            self.loginButton.alpha = 1.0
            self.loginButton.isEnabled = true
        case .inactive:
            self.loginButton.alpha = 0.6
            self.loginButton.isEnabled = false
        }
    }
    
    func areTextFieldsEmpty()->Bool {
        guard let email = emailTextField.textField.text?.isEmpty, let password = passwordTextField.textField.text?.isEmpty else {
            return false
        }
        return email || password
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.layer.borderColor = UIColor.white.cgColor
        textField.superview?.layer.borderWidth = 1
        self.layoutIfNeeded()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.layer.borderWidth = 0
    }
}
