import UIKit

class CardCell:SPSCollectionViewCell{
    var state:SelectedState! {
        didSet{
            stateChange(state: state)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.borderWidth = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
        layer.borderWidth = 5
    }
    
    func stateChange(state:SelectedState){
        switch state {
        case .selected:
            alpha = selectedAlphaValue
            layer.borderColor = UIColor.green.cgColor
        case .deselected:
            alpha = deSelectedAlphaValue
            layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func cellSelected(){
        switch state {
            case .selected:
                state =  .deselected
            case .deselected:
                state =  .selected
        default:
                state =  .selected
        }
    }
}

