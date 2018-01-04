import UIKit

class LoadingView:UIActivityIndicatorView{
    let loadingTextLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white
        self.color = UIColor.black
        self.layer.opacity = 1
        
        loadingTextLabel.text = "Loading..."
        loadingTextLabel.textAlignment = .center
        loadingTextLabel.textColor = UIColor.black
        loadingTextLabel.font = UIFont(name: "Avenir Light", size: 10)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: self.center.x, y: self.center.y + 30)

        self.addSubview(loadingTextLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
