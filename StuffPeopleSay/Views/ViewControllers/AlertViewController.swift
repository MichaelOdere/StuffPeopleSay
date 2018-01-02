import UIKit

class AlertView: UIViewController{

    private var verticalPadding:CGFloat = 100
    private var horizontalPadding:CGFloat = 50
    var contentView = UIView()
    var gameNameTextField = UITextField()
    var gameTextFieldLine = UILabel()
    var numberPicker = UIPickerView()
    var pickerData = Array(1...10)
    var deckButton = UIButton()
    var cancelButton = UIButton()
    var saveButton = UIButton()
    var gameStore:GameStore!
    
    var selectedDeck:String?

    override func viewDidLoad() {

        setupContentView()
        setupButtons()
        setupTextView()
//        setupTextLine()
        setupNumberPicker()
        setupDeckButton()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentView.center.y += view.bounds.height
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.contentView.center.y -= self.view.bounds.height
        })
        
        if let deck = selectedDeck {
            deckButton.setTitle(deck, for: .normal)
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
        let bottom = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -3 * verticalPadding)
        bottom.isActive = true
    
        let leading = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: horizontalPadding)
        leading.isActive = true
       
        let trailing = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -horizontalPadding)
        trailing.isActive = true
    }
    
    func setupButtons(){
        cancelButton.backgroundColor = UIColor.lightGray
        saveButton.backgroundColor = UIColor.lightGray
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)

        cancelButton.setTitle("Cancel", for: .normal)
        saveButton.setTitle("Save", for: .normal)
        
        contentView.addSubview(cancelButton)
        contentView.addSubview(saveButton)

        let cancelBottom = NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        cancelBottom.isActive = true

        let cancelLeading = NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        cancelLeading.isActive = true

        let saveBottom = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        saveBottom.isActive = true

        let saveTrailing = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        saveTrailing.isActive = true

        let widths = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: cancelButton, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        widths.isActive = true

        let equalWidths = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: cancelButton, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        equalWidths.isActive = true
    }
    
    func setupTextView(){
        
        gameNameTextField.backgroundColor = UIColor.lightGray
        gameNameTextField.placeholder = "Enter A Game Name"
        gameNameTextField.layer.cornerRadius = 5
        gameNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(gameNameTextField)
        
        let gameNameTextFieldCenterX = NSLayoutConstraint(item: gameNameTextField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        gameNameTextFieldCenterX.isActive = true
        
        let gameNameTextFieldTop = NSLayoutConstraint(item: gameNameTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 10)
        gameNameTextFieldTop.isActive = true

    }
    
    func setupTextLine(){
        gameTextFieldLine.backgroundColor = UIColor.black
        gameTextFieldLine.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(gameTextFieldLine)
        
        let gameNameTextFieldTop = NSLayoutConstraint(item: gameTextFieldLine, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: gameNameTextField, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        gameNameTextFieldTop.isActive = true
        
//        let gameNameTextFieldHeight = NSLayoutConstraint(item: gameTextFieldLine, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 1)
//        gameNameTextFieldHeight.isActive = true

        let gameNameTextFieldWidth = NSLayoutConstraint(item: gameTextFieldLine, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: gameNameTextField, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        gameNameTextFieldWidth.isActive = true

    }
    
    func setupNumberPicker(){
        numberPicker.backgroundColor = BingoPalette.vanillaBackgroundColor
        numberPicker.layer.cornerRadius = 10
        contentView.addSubview(numberPicker)
        
        numberPicker.translatesAutoresizingMaskIntoConstraints = false
        
        let pickerCenterX = NSLayoutConstraint(item: numberPicker, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        pickerCenterX.isActive = true
        
        let pickerTop = NSLayoutConstraint(item: numberPicker, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: gameNameTextField, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 10)
        pickerTop.isActive = true
        
        let pickerLeading = NSLayoutConstraint(item: numberPicker, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: horizontalPadding)
        pickerLeading.isActive = true
        
        let pickerTrailing = NSLayoutConstraint(item: numberPicker, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -horizontalPadding)
        pickerTrailing.isActive = true
        
        numberPicker.delegate = self
        numberPicker.dataSource = self
    }
    
    func setupDeckButton(){
        deckButton.backgroundColor = UIColor.lightGray
        deckButton.translatesAutoresizingMaskIntoConstraints = false
        deckButton.addTarget(self, action: #selector(showDecks(sender:)), for: .touchUpInside)
        deckButton.setTitle("Select a Deck", for: .normal)
        deckButton.isEnabled = true
        
        contentView.addSubview(deckButton)
        
        let deckCenterX = NSLayoutConstraint(item: deckButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        deckCenterX.isActive = true
        
        let deckTop = NSLayoutConstraint(item: deckButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: numberPicker, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 10)
        deckTop.isActive = true
    }
    
    @objc func cancel(sender:UIButton){
//        UIView.animate(withDuration: 0.2, animations: {
//            self.view.alpha = 0
//
//        }, completion: {  (finished: Bool) in
//            self.dismiss(animated: false, completion: nil)
//        })
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
        vc.delegate = self
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
}

extension AlertView:MyProtocol{
    func setResultOfBusinessLogic(valueSent: String) {
        self.selectedDeck = valueSent
    }
}
