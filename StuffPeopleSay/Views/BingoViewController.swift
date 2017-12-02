import UIKit

class BingoViewController:UIViewController{
    var bingoGame:BingoGame = BingoGame()
    var gameIndex:Int!
    var gameStore:GameStore!
    var pushManager:PusherManager!

    var loadingView:UIActivityIndicatorView!
    let pieceTransparency:CGFloat = 0.2
    
    var bingoDataSource:BingoCollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {

        loadingView = UIActivityIndicatorView(frame: self.view.frame)
        loadingView.backgroundColor = UIColor.gray
        loadingView.layer.opacity = 0.8
        
        bingoDataSource = BingoCollectionView()

        bingoDataSource.didSelectRow = didSelectRow(card:cell:)
        bingoDataSource.bingoGame = bingoGame
        bingoDataSource.deck = gameStore.games[gameIndex].my.deck

        collectionView.dataSource = bingoDataSource
        collectionView.delegate = bingoDataSource

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
    
    func didSelectRow(card: Card, cell: BingoCollectionCell) {

        if self.gameStore.games[gameIndex].status.lowercased() != "playing"{
            return
        }

        self.gameStore.apiManager.updateBoard(boardCardId: card.boardCardId)
        
        let x = cell.xIndex!
        let y = cell.yIndex!

        if card.active == 1{
            cell.pieceView.alpha = 0.0
            bingoGame.board[x][y] = 0
        }else{
            cell.pieceView.alpha = pieceTransparency
            bingoGame.board[x][y] = 1
        }
        
        if (bingoGame.checkVictory(x: x, y: y)){

            self.gameStore.games[gameIndex].status = "ended"
            self.gameStore.apiManager.updateGame(gameId: self.gameStore.games[gameIndex].gameId)
            showAlert {
                self.bingoGame.boardReset()
                self.collectionView.reloadData()
            }

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
    
    @objc func didBecomeActive(){
        let oldGameId = self.gameStore.games[gameIndex].gameId
        if self.gameStore.isLoggedIn{
            self.loadingView.startAnimating()
            self.view.addSubview(self.loadingView)
            
            let group = DispatchGroup()
            group.enter()
            self.gameStore.updateGames(completionHandler: { error in
                group.leave()
                
            })
            
            group.notify(queue: DispatchQueue.main){
                
                let g = self.gameStore.games.filter({ $0.gameId == oldGameId })
                if g.first != nil{
                    self.gameStore.games[self.gameIndex] = g.first!
                }
                
                self.tableview.reloadData()
                self.collectionView.reloadData()
                
                self.loadingView.stopAnimating()
                self.loadingView.removeFromSuperview()
            
            }
            
        }
        
    }
   
}

extension BingoViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.self.gameStore.games[gameIndex].users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user =  self.self.gameStore.games[gameIndex].users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")
        
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text =  "Cards active: " + String(user.count)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "OpponentBingoViewController") as! OpponentBingoViewController
        
        vc.user = gameStore.games[gameIndex].users[indexPath.row]

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
