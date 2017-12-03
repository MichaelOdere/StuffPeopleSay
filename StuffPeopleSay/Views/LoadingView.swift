import UIKit

class LoadingView:UIActivityIndicatorView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.gray
        self.layer.opacity = 1
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
