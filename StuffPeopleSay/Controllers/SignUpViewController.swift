import UIKit

class SignUpViewController: UIViewController {
    var signUpView: SignUpView!

    override func viewDidLoad() {
        signUpView = SignUpView(frame: self.view.frame)
        view.backgroundColor = BingoPalette.bingoCellBackgroundColor
        view.addSubview(signUpView)

        self.title = "SignUp"
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
