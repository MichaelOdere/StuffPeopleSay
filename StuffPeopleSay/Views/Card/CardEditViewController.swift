import UIKit

class CardEditViewController: UIViewController{
    var deck:Deck!
    var cardEditView:CardEditView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardEditView = CardEditView(frame: view.frame)
        cardEditView.collectionView.delegate = self
        view.addSubview(cardEditView)
        
        cardEditView.setDataSource(deck: deck)
    }
}

extension CardEditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

