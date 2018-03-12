import UIKit

protocol AddedDeckProtocol: class {
    func addedANewDeck()
}

class AlertViewController: UIViewController {
    var addedDeckProtocol: AddedDeckProtocol?
    var alertView: AlertView!
    var gameStore: GameStore!
    var selectedDeck: Deck?
    var hasLoaded: Bool = false

    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear

        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular ))
        blurView.frame = view.bounds
        view.addSubview(blurView)

        alertView = AlertView(frame: self.view.frame)
        view.addSubview(alertView)
        setupAlertView()
    }

    override func viewWillAppear(_ animated: Bool) {
        if !hasLoaded {
            alertView.animateShow()
            hasLoaded = true
        }
        if let deck = selectedDeck {
            alertView.deckButton.setTitle(deck.name, for: .normal)
            alertView.deckButton.backgroundColor = UIColor.green
        } else {
            alertView.deckButton.setTitle("Select a Deck", for: .normal)
            alertView.deckButton.backgroundColor = UIColor.red
        }
    }

    func setupAlertView() {
        alertView.deckButton.addTarget(self, action: #selector(showDecks(sender:)), for: .touchUpInside)
        alertView.cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        alertView.saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)
    }

    @objc func cancel(sender: UIButton) {
        alertView.animateDismiss {
            self.dismiss(animated: false, completion: nil)
        }
    }

    @objc func save(sender: UIButton) {
        if alertView.gameNameTextField.text?.isEmpty == false && selectedDeck != nil {
            let boardsCount = alertView.pickerData[alertView.numberPicker.selectedRow(inComponent: 0)]
            gameStore.createGame(name: alertView.gameNameTextField.text!,
                                 boards: boardsCount,
                                 deckId: (selectedDeck?.id)!,
                                 completionHandler: { (game) in
                                    if game != nil {
                                        self.addedDeckProtocol?.addedANewDeck()
                                    }
                                })
            alertView.animateDismiss {
                self.dismiss(animated: false, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Not Enough Information!",
                                          message: "Make sure you have filled out all of the required fields",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc func showDecks(sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let id = "DeckShowViewController"
        let vcOptional = sb.instantiateViewController(withIdentifier: id) as? DeckShowViewController
        guard let vc = vcOptional else {
            fatalError("DeckShowViewController not found.")
        }
        vc.gameStore = gameStore
        vc.selectDeck = self
        present(vc, animated: true, completion: nil)
    }
}

extension AlertViewController: SelectDeckProtocol {
    func sendSelectedDeck(valueSent: Deck) {
        self.selectedDeck = valueSent
    }
}
