import UIKit

enum ButtonState {
    case active
    case inactive
}

class LoginView: UIView {
    var loginButton = UIButton(type: .system)
    var emailView = TitleInputView()
    var passwordView = TitleInputView()

    var verticlePadding: CGFloat = 10
    var horizontalPadding: CGFloat = 50

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = BingoPalette.silverBackgroundColor

        self.addSubview(emailView)
        self.addSubview(passwordView)
        self.addSubview(loginButton)

        setupEmailView()
        setupPasswordView()
        setupLoginButton()

        // tap to remove keyboard
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:))))
    }

    func setupEmailView() {
        emailView.titleLabel.text = "Email"
        emailView.textField.delegate = self
        emailView.textField.addTarget(self, action: #selector(LoginView.textFieldDidChange(_:)),
                                           for: UIControlEvents.editingChanged)

        emailView.translatesAutoresizingMaskIntoConstraints = false

        let bottom = NSLayoutConstraint(item: emailView, attribute: .bottom, relatedBy: .equal, toItem: passwordView, attribute: .top, multiplier: 1, constant: -verticlePadding)
        bottom.isActive = true

        let leading = NSLayoutConstraint(item: emailView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: emailView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true

        emailView.layoutSubviews()
    }

    func setupPasswordView() {
        passwordView.titleLabel.text = "Password"
        passwordView.textField.isSecureTextEntry = true
        passwordView.textField.delegate = self
        passwordView.textField.addTarget(self, action: #selector(LoginView.textFieldDidChange(_:)),
                                              for: UIControlEvents.editingChanged)

        passwordView.translatesAutoresizingMaskIntoConstraints = false

        let centerY = NSLayoutConstraint(item: passwordView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        centerY.isActive = true

        let leading = NSLayoutConstraint(item: passwordView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: passwordView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true

        let equalHeight = NSLayoutConstraint(item: passwordView, attribute: .height, relatedBy: .equal, toItem: emailView, attribute: .height, multiplier: 1, constant: 0)
        equalHeight.isActive = true

        let height = NSLayoutConstraint(item: passwordView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.frame.height * 0.07)
        height.isActive = true
    }

    func setupLoginButton() {
        loginButton.adjustsImageWhenHighlighted = true
        loginButton.backgroundColor = BingoPalette.SPSred
        loginButton.setTitle("Login", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitleColor(UIColor.white, for: .normal)
        configureButton(for: .inactive)

        let top = NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passwordView, attribute: .bottom, multiplier: 1, constant: verticlePadding * 1.5)
        top.isActive = true

        let leading = NSLayoutConstraint(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: loginButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true

        let height = NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: passwordView, attribute: .height, multiplier: 0.8, constant: 0)
        height.isActive = true
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if areTextFieldsEmpty() {
            configureButton(for: .inactive)
        } else {
            configureButton(for: .active)
        }
    }

    func configureButton(for state: ButtonState) {
        switch state {
        case .active:
            self.loginButton.alpha = 1.0
            self.loginButton.isEnabled = true
        case .inactive:
            self.loginButton.alpha = 0.6
            self.loginButton.isEnabled = false
        }
    }

    func areTextFieldsEmpty() -> Bool {
        guard let email = emailView.textField.text?.isEmpty, let password = passwordView.textField.text?.isEmpty else {
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
        textField.superview?.layer.borderColor = UIColor.red.cgColor
        textField.superview?.layer.shadowOpacity = 0.5
        self.layoutIfNeeded()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.layer.borderColor = UIColor.lightGray.cgColor
        textField.superview?.layer.shadowOpacity = 0.0
    }
}
