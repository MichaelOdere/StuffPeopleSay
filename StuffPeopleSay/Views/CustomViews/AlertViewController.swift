import UIKit

class AlertView: UIViewController{

    private var verticalPadding:CGFloat = 100
    private var horizontalPadding:CGFloat = 50
    var contentView = UIView()
    var cancelButton = UIButton()
    var saveButton = UIButton()
    override func viewDidLoad() {
        setupContentView()
        setupButtons()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    func setupContentView(){
        contentView.backgroundColor = UIColor.blue
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        let top = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: verticalPadding)
        top.isActive = true
        let bottom = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -verticalPadding)
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
    
    @objc func cancel(sender:UIButton){
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 0

        }, completion: {  (finished: Bool) in
            self.dismiss(animated: false, completion: nil)
        })
    }
}
