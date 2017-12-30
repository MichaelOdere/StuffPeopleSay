import UIKit

class AlertView: UIViewController{

    private var verticalPadding:CGFloat = 100
    private var horizontalPadding:CGFloat = 50
    var contentView = UIView()
    var gameNameTextField = UITextField()
    var numberPicker = UIPickerView()
    var pickerData = Array(1...10)
    var deckButton = UIButton()
    var cancelButton = UIButton()
    var saveButton = UIButton()
    var gameStore:GameStore!

    override func viewDidLoad() {
        setupContentView()
        setupButtons()
        setupTextView()
        setupNumberPicker()
        setupDeckButton()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    func setupContentView(){
        contentView.backgroundColor = UIColor.blue
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
        cancelButton.backgroundColor = UIColor.red
        saveButton.backgroundColor = UIColor.flatPink()
        
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
        
        let equalWidths = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: cancelButton, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        equalWidths.isActive = true
    }
    
    func setupTextView(){
        
        gameNameTextField.backgroundColor = UIColor.white
        gameNameTextField.placeholder = "Enter A Game Name"
        
        gameNameTextField.layer.cornerRadius = 5
        gameNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(gameNameTextField)
        
        let gameNameTextFieldCenterX = NSLayoutConstraint(item: gameNameTextField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        gameNameTextFieldCenterX.isActive = true
        
        let gameNameTextFieldTop = NSLayoutConstraint(item: gameNameTextField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 10)
        gameNameTextFieldTop.isActive = true

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
        deckButton.backgroundColor = BingoPalette.vanillaBackgroundColor
        deckButton.translatesAutoresizingMaskIntoConstraints = false
        deckButton.addTarget(self, action: #selector(showDecks(sender:)), for: .touchUpInside)
        deckButton.setTitle("Select a Deck", for: .normal)
        deckButton.isEnabled = true
        
        contentView.addSubview(deckButton)
        
        let deckCenterX = NSLayoutConstraint(item: deckButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        deckCenterX.isActive = true
        
        let deckTop = NSLayoutConstraint(item: deckButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: numberPicker, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 10)
        deckTop.isActive = true
        
//        let deckLeading = NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 10)
//        deckLeading.isActive = true
//
//        let deckTrailing = NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 10)
//        deckTrailing.isActive = true
    }
    
    @objc func cancel(sender:UIButton){
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0

        }, completion: {  (finished: Bool) in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @objc func showDecks(sender:UIButton){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DeckViewController") as! DeckViewController
        vc.gameStore = gameStore
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
