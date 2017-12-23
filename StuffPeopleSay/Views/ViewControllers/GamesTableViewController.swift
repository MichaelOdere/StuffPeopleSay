import UIKit
import SwiftyJSON
import ChameleonFramework

class GamesTableViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{

    var gameStore:GameStore!
    
    var loadingView:LoadingView!

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        loadingView = LoadingView(frame: self.view.frame)
        
        tableview.delegate = self
        tableview.dataSource = self

        NotificationCenter.default.addObserver(self,
                                                 selector: #selector(GamesTableViewController.didBecomeActive),
                                                 name: Notification.Name("didBecomeActive"),
                                                 object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectionIndexPath = tableview.indexPathForSelectedRow {
            tableview.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameStore.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameViewCell
        
        let game = gameStore.games[indexPath.row]
        cell.deckTypeLabel.text = "Los Angeles"
        cell.oppponentsLabel.text = game.getOpponents()
        cell.statusLabel.text = game.status
        cell.statusView.backgroundColor = game.getSatusColor()
        cell.statusView.layer.cornerRadius = cell.statusView.frame.width / 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BoardCollectionViewController") as! BoardCollectionViewController

        vc.game = self.gameStore.games[indexPath.row]
        vc.apiManager = self.gameStore.apiManager
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func newCard(_ sender: Any) {
        let alert = UIAlertController(title: "Type in the card you'd like to add",
                                       message: nil,
                                       preferredStyle: .alert)

        alert.addTextField(configurationHandler: nil)

        let add = UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            guard let cardText = textField?.text else {return}
            if !cardText.isEmpty{
                self.gameStore.apiManager.createCard(name: cardText)
            }
        })
        alert.addAction(add)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func newGame(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to Create a new game?",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let add = UIAlertAction(title: "Create", style: .default, handler: { [weak alert] (_) in
            self.addNewGame()
        })
        alert.addAction(add)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func addNewGame(){
        self.gameStore.apiManager.createGame(completionHandler: { data, error in
            
            guard let data = data else {
                print(error as Any)
                return
            }
            
            do {

                let json = try JSON(data: data)
                if let game = Game(json: json){
                    self.gameStore.games.insert(game, at: 0)
                    print("New game added")
                }
                
            } catch {
                print(error)
            }
            
            DispatchQueue.main.sync {
                self.tableview.reloadData()
            }
                
            
        })
    }
    
    @objc func didBecomeActive(){

        if self.gameStore.isLoggedIn{
            self.loadingView.startAnimating()
            self.view.addSubview(self.loadingView)

            let group = DispatchGroup()
            group.enter()
            self.gameStore.updateGames(completionHandler: { error in
                group.leave()
                
            })
            
            group.notify(queue: DispatchQueue.main){
                
                self.loadingView.stopAnimating()
                self.loadingView.removeFromSuperview()
                self.tableview.reloadData()
            }
            
        }
    
    }
}

/*
let sb = UIStoryboard(name: "Main", bundle: nil)
let vc = sb.instantiateViewController(withIdentifier: "BingoController") as! BingoViewController

vc.gameStore = self.gameStore
vc.gameIndex = gameStore.games.index(where: { (item) -> Bool in
    item.gameId == self.gameStore.games[indexPath.row].gameId
})

self.navigationController?.pushViewController(vc, animated: true)
*/
