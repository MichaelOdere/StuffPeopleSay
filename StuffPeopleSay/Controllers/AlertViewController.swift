import UIKit

class AlertView: UIViewController{
    private var verticalPadding:CGFloat!
    private var verticleSpaceBetweenElements:CGFloat!
    private var horizontalPadding:CGFloat!
    var contentView = UIView()
    var gameNameTextField = UITextField()
    var gameTextFieldLine = UILabel()
    var numberPicker = UIPickerView()
    var pickerData = Array(1...10)
    var deckButton = UIButton()
    var cancelButton = UIButton()
    var saveButton = UIButton()
    var gameStore:GameStore!
    var selectedDeck:Deck?
    var hasLoaded:Bool = false
    
    override func viewDidLoad() {
        verticalPadding = self.view.frame.height * 0.1
        verticleSpaceBetweenElements = 10
        horizontalPadding = self.view.frame.width * 0.05

        setupContentView()
        setupButtons()
        setupTextView()
        setupNumberPicker()
        setupDeckButton()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        gameNameTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !hasLoaded{
            contentView.center.y += view.bounds.height
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.contentView.center.y -= self.view.bounds.height
            })
            hasLoaded = true
        }
        if let deck = selectedDeck {
            deckButton.setTitle(deck.name, for: .normal)
        }else{
            deckButton.setTitle("Select a Deck", for: .normal)
        }
    }
    
    func setupContentView(){
        contentView.backgroundColor = UIColor.white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        let top = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: verticalPadding)
        top.isActive = true
        let bottom = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -5 * verticalPadding)
        bottom.isActive = true
    
        let leading = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
       
        let trailing = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
    }
    
    func setupButtons(){
        cancelButton.backgroundColor = contentView.backgroundColor
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.gray, for: .normal)
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor
        cancelButton.layer.borderWidth = 0.8
        cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cancelButton)

        saveButton.backgroundColor = contentView.backgroundColor
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.gray, for: .normal)
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        saveButton.layer.borderWidth = 0.8
        saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(saveButton)

        let cancelBottom = NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        cancelBottom.isActive = true

        let cancelLeading = NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        cancelLeading.isActive = true

        let saveBottom = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        saveBottom.isActive = true

        let saveTrailing = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        saveTrailing.isActive = true

        let widths = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cancelButton, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -1)
        widths.isActive = true

        let equalWidths = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: cancelButton, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        equalWidths.isActive = true
    }
    
    func setupTextView(){
        gameNameTextField.placeholder = "Enter A Game Name"
        gameNameTextField.backgroundColor = UIColor.white
        gameNameTextField.textAlignment = .center
        gameNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        gameNameTextField.layer.borderWidth = 0.8
        gameNameTextField.returnKeyType = .done
        gameNameTextField.layer.cornerRadius = 5
        gameNameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gameNameTextField)
        

        let gameNameTextFieldTop = NSLayoutConstraint(item: gameNameTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: verticleSpaceBetweenElements)
        gameNameTextFieldTop.isActive = true
        
        let gameNameTextFieldLeading = NSLayoutConstraint(item: gameNameTextField, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: horizontalPadding)
        gameNameTextFieldLeading.isActive = true
        
        let gameNameTextFieldTrailing = NSLayoutConstraint(item: gameNameTextField, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -horizontalPadding)
        gameNameTextFieldTrailing.isActive = true
    }
    
    func setupTextLine(){
        gameTextFieldLine.backgroundColor = UIColor.black
        gameTextFieldLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gameTextFieldLine)
        
        let gameNameTextFieldTop = NSLayoutConstraint(item: gameTextFieldLine, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: gameNameTextField, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        gameNameTextFieldTop.isActive = true

        let gameNameTextFieldWidth = NSLayoutConstraint(item: gameTextFieldLine, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: gameNameTextField, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        gameNameTextFieldWidth.isActive = true

    }
    
    func setupNumberPicker(){
        numberPicker.backgroundColor = UIColor.white
        numberPicker.layer.cornerRadius = 10
        numberPicker.layer.borderColor = UIColor.lightGray.cgColor
        numberPicker.layer.borderWidth = 0.8
        numberPicker.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(numberPicker)
        
        let pickerCenterX = NSLayoutConstraint(item: numberPicker, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        pickerCenterX.isActive = true
        
        let pickerTop = NSLayoutConstraint(item: numberPicker, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: gameNameTextField, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: verticleSpaceBetweenElements)
        pickerTop.isActive = true
        
        let pickerLeading = NSLayoutConstraint(item: numberPicker, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: horizontalPadding)
        pickerLeading.isActive = true
        
        let pickerTrailing = NSLayoutConstraint(item: numberPicker, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -horizontalPadding)
        pickerTrailing.isActive = true
        
        numberPicker.setContentCompressionResistancePriority(.init(1), for: .vertical)
        numberPicker.setContentHuggingPriority(.init(1), for: .vertical)
        
        numberPicker.delegate = self
        numberPicker.dataSource = self
    }
    
    func setupDeckButton(){
        deckButton.backgroundColor = UIColor.lightGray
        deckButton.addTarget(self, action: #selector(showDecks(sender:)), for: .touchUpInside)
        deckButton.setTitle("Select a Deck", for: .normal)
        deckButton.isEnabled = true
        deckButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deckButton)
        
        let deckCenterX = NSLayoutConstraint(item: deckButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        deckCenterX.isActive = true
        
        let deckTop = NSLayoutConstraint(item: deckButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: numberPicker, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: verticleSpaceBetweenElements)
        deckTop.isActive = true
        
        let deckBottom = NSLayoutConstraint(item: deckButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: cancelButton, attribute: NSLayoutAttribute.top, multiplier: 1, constant: -verticleSpaceBetweenElements)
        deckBottom.isActive = true
    }
    
    @objc func cancel(sender:UIButton){
        animateDissmiss()
    }
    
    @objc func save(sender:UIButton){
        if !(gameNameTextField.text?.isEmpty)! && selectedDeck != nil{
            //Save logic
            animateDissmiss()
        }
    }
    
    func animateDissmiss(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.contentView.center.y += self.view.bounds.height
        }, completion: {  (finished: Bool) in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @objc func showDecks(sender:UIButton){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ShowDeckViewController") as! ShowDeckViewController
        vc.gameStore = gameStore
        vc.myDelegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension AlertView:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
       
        if pickerData[row] == 1{
            return NSAttributedString(string: String(pickerData[row]) + " Board")
        }
        return NSAttributedString(string: String(pickerData[row]) + " Boards")
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AlertView:MyProtocol{
    func sendSelectedDeck(valueSent: Deck) {
        self.selectedDeck = valueSent
    }
}

extension AlertView:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
