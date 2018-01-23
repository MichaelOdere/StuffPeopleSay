import UIKit

protocol AddedDeckProtocol: class {
    func addedANewDeck()
}

class AlertViewController: UIViewController{
   
    var addedDeckProtocol:AddedDeckProtocol?
    var alertView:AlertView!
    var gameStore:GameStore!
    var selectedDeck:Deck?
    var hasLoaded:Bool = false

    override func viewDidLoad() {
        alertView = AlertView(frame: self.view.frame)
        self.view.addSubview(alertView)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        alertView.gameNameTextField.delegate = self

        alertView.numberPicker.delegate = self
        alertView.numberPicker.dataSource = self

        alertView.deckButton.addTarget(self, action: #selector(showDecks(sender:)), for: .touchUpInside)
        alertView.cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        alertView.saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        if !hasLoaded{
            self.view.alpha = 0.3
            alertView.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.view.alpha = 1
                self.alertView.contentView.transform = .identity
            })
            hasLoaded = true
        }
        if let deck = selectedDeck {
            alertView.deckButton.setTitle(deck.name, for: .normal)
        }else{
            alertView.deckButton.setTitle("Select a Deck", for: .normal)
        }
    }

 
    @objc func cancel(sender:UIButton){
        animateDissmiss()
    }

    @objc func save(sender:UIButton){

        if !(alertView.gameNameTextField.text?.isEmpty)! && selectedDeck != nil{

            let boardsCount = alertView.pickerData[alertView.numberPicker.selectedRow(inComponent: 0)]

            gameStore.createGame(name: alertView.gameNameTextField.text!, boards: boardsCount, deckId: (selectedDeck?.id)!, completionHandler: { (game) in
                if game != nil{
                    self.addedDeckProtocol?.addedANewDeck()
                }
            })
            animateDissmiss()
        }
    }

    func animateDissmiss(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.view.alpha = 0.0
        }, completion: {  (finished: Bool) in
            self.dismiss(animated: false, completion: nil)
        })
    }

    @objc func showDecks(sender:UIButton){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DeckShowViewController") as! DeckShowViewController
        vc.gameStore = gameStore
        vc.selectDeck = self
        present(vc, animated: true, completion: nil)
    }
}

extension AlertViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alertView.pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(alertView.pickerData[row])
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        if alertView.pickerData[row] == 1{
            return NSAttributedString(string: String(alertView.pickerData[row]) + " Board")
        }
        return NSAttributedString(string: String(alertView.pickerData[row]) + " Boards")
    }


    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AlertViewController:SelectDeckProtocol{
    func sendSelectedDeck(valueSent: Deck) {
        self.selectedDeck = valueSent
    }
}

extension AlertViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

