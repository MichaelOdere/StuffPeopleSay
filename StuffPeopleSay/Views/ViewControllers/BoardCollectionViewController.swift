import UIKit

class BoardCollectionViewController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var game:Game!
    var apiManager:APIManager!

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.my.boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath) as! BoardCollectionViewCell
        
        let cardCount = game.my.getCardsActive(index: indexPath.row)
        let cardString = cardCount == 1 ? "card" : "cards"
        cell.titleLabel.text = String(cardCount) + " \(cardString) active"
        cell.bingoDataSource.deck = game.my.boards[indexPath.row]
        cell.setDelegation()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BingoController") as! BingoViewController
        
        vc.users = self.game.users
        vc.deck = self.game.my.boards[indexPath.row]
        vc.status = self.game.status
        vc.gameId = self.game.gameId
        vc.apiManager = self.apiManager
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func tappedButton(_ sender: Any) {
        print("buttonTapped")
    }
}
