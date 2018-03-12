import UIKit

class CardCell: SPSCollectionViewCell {
    var state: SelectedState! {
        didSet {
            stateChange(state: state)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.borderWidth = 5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func stateChange(state: SelectedState) {
        switch state {
        case .selected:
            alpha = selectedAlphaValue
            layer.borderColor = BingoPalette.SPSgreen.cgColor
        case .deselected:
            alpha = deSelectedAlphaValue
            layer.borderColor = BingoPalette.SPSred.cgColor
        }
    }

    func cellSelected() {
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
