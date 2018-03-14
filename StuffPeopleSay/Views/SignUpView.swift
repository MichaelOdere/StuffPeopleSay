import UIKit

class SignUpView: UIView {
    var signUpButton = UIButton(type: .system)
    var emailView = TitleInputView()
    var passwordView = TitleInputView()
    var confirmPasswordView = TitleInputView()

    var verticlePadding: CGFloat = 10
    var horizontalPadding: CGFloat = 50

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = BingoPalette.silverBackgroundColor

        setupEmailView()
        setupPasswordView()
        setupConfirmPasswordView()
        setupsignUpButton()

        // tap to remove keyboard
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:))))
    }

    func setupEmailView() {
        addSubview(emailView)
        emailView.titleLabel.text = "Email"
        emailView.textField.delegate = self
        emailView.textField.addTarget(self, action: #selector(LoginView.textFieldDidChange(_:)),
                                      for: UIControlEvents.editingChanged)
        emailView.translatesAutoresizingMaskIntoConstraints = false

        let leading = NSLayoutConstraint(item: emailView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: emailView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true

        emailView.layoutSubviews()
    }

    func setupPasswordView() {
        addSubview(passwordView)
        passwordView.titleLabel.text = "Password"
        passwordView.textField.isSecureTextEntry = true
        passwordView.textField.delegate = self
        passwordView.textField.addTarget(self, action: #selector(LoginView.textFieldDidChange(_:)),
                                         for: UIControlEvents.editingChanged)

        passwordView.translatesAutoresizingMaskIntoConstraints = false

        let top = NSLayoutConstraint(item: passwordView, attribute: .top, relatedBy: .equal, toItem: emailView, attribute: .bottom, multiplier: 1, constant: verticlePadding * 1.5)
        top.isActive = true

        let leading = NSLayoutConstraint(item: passwordView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: passwordView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true

        let equalHeight = NSLayoutConstraint(item: passwordView, attribute: .height, relatedBy: .equal, toItem: emailView, attribute: .height, multiplier: 1, constant: 0)
        equalHeight.isActive = true

        let height = NSLayoutConstraint(item: passwordView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.frame.height * 0.07)
        height.isActive = true
    }

    func setupConfirmPasswordView() {
        addSubview(confirmPasswordView)
        confirmPasswordView.titleLabel.text = "Confirm Password"
        confirmPasswordView.textField.isSecureTextEntry = true
        confirmPasswordView.textField.delegate = self
        confirmPasswordView.textField.addTarget(self, action: #selector(LoginView.textFieldDidChange(_:)),
                                         for: UIControlEvents.editingChanged)

        confirmPasswordView.translatesAutoresizingMaskIntoConstraints = false

        let centerY = NSLayoutConstraint(item: confirmPasswordView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        centerY.isActive = true

        let top = NSLayoutConstraint(item: confirmPasswordView, attribute: .top, relatedBy: .equal, toItem: passwordView, attribute: .bottom, multiplier: 1, constant: verticlePadding * 1.5)
        top.isActive = true

        let leading = NSLayoutConstraint(item: confirmPasswordView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: confirmPasswordView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true

        let equalHeight = NSLayoutConstraint(item: confirmPasswordView, attribute: .height, relatedBy: .equal, toItem: passwordView, attribute: .height, multiplier: 1, constant: 0)
        equalHeight.isActive = true
    }

    func setupsignUpButton() {
        addSubview(signUpButton)
        signUpButton.adjustsImageWhenHighlighted = true
        signUpButton.backgroundColor = BingoPalette.SPSred
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        configureButton(for: .inactive)

        let top = NSLayoutConstraint(item: signUpButton, attribute: .top, relatedBy: .equal, toItem: confirmPasswordView, attribute: .bottom, multiplier: 1, constant: verticlePadding * 1.5)
        top.isActive = true

        let leading = NSLayoutConstraint(item: signUpButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true

        let trailing = NSLayoutConstraint(item: signUpButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true

        let height = NSLayoutConstraint(item: signUpButton, attribute: .height, relatedBy: .equal, toItem: passwordView, attribute: .height, multiplier: 0.8, constant: 0)
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
            self.signUpButton.alpha = 1.0
            self.signUpButton.isEnabled = true
        case .inactive:
            self.signUpButton.alpha = 0.6
            self.signUpButton.isEnabled = false
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

extension SignUpView: UITextFieldDelegate {
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
