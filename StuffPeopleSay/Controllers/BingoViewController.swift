import UIKit

class BingoViewController:UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    
    var bingoGame:BingoBoard = BingoBoard()
    var users:[User]!
    var board:Board!
    var status:String!
    var gameId:String!
    var gameStore:GameStore!
    var loadingView:LoadingView!
    let pieceTransparency:CGFloat = 0.2
    var bingoCollectionView:BingoCollectionView!

    override func viewDidLoad() {
        loadingView = LoadingView(frame: self.view.frame)
        
        bingoCollectionView = BingoCollectionView()
        bingoCollectionView.bingoGame = bingoGame
        bingoCollectionView.deck = board.boardDeck
        bingoCollectionView.didSelectDelegate = self
        
        collectionView.dataSource = bingoCollectionView
        collectionView.delegate = bingoCollectionView
        
        tableview.dataSource = self
        tableview.delegate = self

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(BingoViewController.didBecomeActive),
                                               name: Notification.Name("didBecomeActive"),
                                               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectionIndexPath = tableview.indexPathForSelectedRow {
            tableview.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    func showAlert(completion: @escaping ()->()){
        let alert = UIAlertController(title: "Congratulations You Won!",
                                      message: "We're sorry you had to hear all that!!",
                                      preferredStyle: .alert)

        let action = UIAlertAction(title: "I'm The Best", style: .default,
                                         handler: { (action) -> Void in
                               completion()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    // for this to work need to change updateGames to physically update each game instead of wiping the games
    @objc func didBecomeActive(){
//        let oldGameId = self.game.gameId
//        if self.gameStore.isLoggedIn{
//            self.loadingView.startAnimating()
//            self.view.addSubview(self.loadingView)
//
//            let group = DispatchGroup()
//            group.enter()
//            self.gameStore.updateGames(completionHandler: { error in
//                group.leave()
//
//            })
//
//            group.notify(queue: DispatchQueue.main){
//
//                let g = self.gameStore.games.filter({ $0.gameId == oldGameId })
//                if g.first != nil{
//                    self.gameStore.games[self.gameIndex] = g.first!
//                }
//
//                self.tableview.reloadData()
//                self.collectionView.reloadData()
//
//                self.loadingView.stopAnimating()
//                self.loadingView.removeFromSuperview()
//
//            }
//
//        }
//
//    }
        print("active!")
    }
}
extension BingoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user =  self.self.users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")
        
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text =  "Cards active: " //+ String(user.boards[i] count)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "OpponentBingoViewController") as! OpponentBingoViewController
        
        vc.user = self.users[indexPath.row]

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BingoViewController : ZoomViewController{
    func zoomingCollectionView(for transition: ZoomTransitioningDelegate) -> UICollectionView? {
        if let cv = collectionView{
          return cv
        }
        return nil
    }
}

extension BingoViewController:BingoCollectionViewDelegate{
    func specificDidSelectRow(card: BoardDeckCard, cell: BingoCollectionCell) {
        if self.self.status.lowercased() != "playing"{
            return
        }
        
        self.gameStore.updateBoard(boardCardId: card.boardCardId) { (success) in
            print("Success")
        }
        
        let x = cell.xIndex!
        let y = cell.yIndex!
        
        if card.active{
            cell.pieceView.alpha = 0.0
            bingoGame.board[x][y] = 0
        }else{
            cell.pieceView.alpha = pieceTransparency
            bingoGame.board[x][y] = 1
        }
        
        if (bingoGame.checkVictory(x: x, y: y)){
            self.status = "ended"

            self.gameStore.updateGame(gameId: gameId, completionHandler: { (success) in
                print("success")
            })
            showAlert {
                self.bingoGame.boardReset()
                self.collectionView.reloadData()
            }
        }
    }
}
