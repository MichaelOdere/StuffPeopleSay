import UIKit

class BoardCollectionViewController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var game:Game!
    var apiManager:APIManager!
    var selectedIndexPath:IndexPath!
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
        self.selectedIndexPath = indexPath
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BingoController") as! BingoViewController
        
        vc.users = self.game.users
        vc.deck = self.game.my.boards[indexPath.row]
        vc.status = self.game.status
        vc.gameId = self.game.gameId
        vc.apiManager = self.apiManager
        
//        self.performSegue(withIdentifier: "ShowBoards", sender: vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowBoards"{
//            print("made it")
//            let vc = sender as! BingoViewController
//            let boardVC = segue.destination as! BingoViewController
//
//            boardVC.users = vc.users
//            boardVC.deck = vc.deck
//            boardVC.status = vc.status
//            boardVC.gameId = vc.gameId
//            boardVC.apiManager = vc.apiManager
//        }
//    }

}

extension BoardCollectionViewController : ZoomViewController{
    func zoomingCollectionView(for transition: ZoomTransitioningDelegate) -> UICollectionView? {
        print("here we made it")
        if let indexPath = selectedIndexPath{
            let cell = collectionView?.cellForItem(at: indexPath) as! BoardCollectionViewCell
            return cell.board
        }
        return nil
    }
}
