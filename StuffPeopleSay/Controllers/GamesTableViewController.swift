import UIKit
import SwiftyJSON
import ChameleonFramework

class GamesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableview: UITableView!
    var gameStore: GameStore!
    var loadingView: LoadingView!

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameViewCell else {
            fatalError("The dequeued cell is not an instance of GameTable.")
        }
        let game = gameStore.games[indexPath.row]
        cell.deckTypeLabel.text = "game.name"
        cell.oppponentsLabel.text = game.getOpponents()
        cell.statusLabel.text = game.status
        cell.statusView.backgroundColor = game.getSatusColor()
        cell.statusView.layer.cornerRadius = cell.statusView.frame.width / 2
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let id = "BoardCollectionViewController"
        let vcOptional = sb.instantiateViewController(withIdentifier: id) as? BoardCollectionViewController

        guard let vc = vcOptional else {
            fatalError("BoardCollectionViewController not found.")
        }

        vc.game = self.gameStore.games[indexPath.row]
        vc.gameStore = self.gameStore
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func showDecks(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let id = "DeckEditViewController"
        let vcOptional = sb.instantiateViewController(withIdentifier: id) as? DeckEditViewController

        guard let vc = vcOptional else {
            fatalError("DeckEditViewController not found.")
        }

        vc.gameStore = gameStore
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func newGame(_ sender: Any) {
        let alertView = AlertViewController()
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.gameStore = gameStore
        alertView.addedDeckProtocol = self
        present(alertView, animated: false, completion: nil)
    }

    @objc func didBecomeActive() {
        //        if self.gameStore.isLoggedIn{
        //            self.loadingView.startAnimating()
        //            self.view.addSubview(self.loadingView)
        //
        //            let group = DispatchGroup()
        //            group.enter()
        //            self.gameStore.updateGames(completionHandler: { error in
        //                group.leave()
        //            })
        //            group.notify(queue: DispatchQueue.main){
        //                self.loadingView.stopAnimating()
        //                self.loadingView.removeFromSuperview()
        //                self.tableview.reloadData()
        //            }
        //        }
    }
}

extension GamesTableViewController: AddedDeckProtocol {
    func addedANewDeck() {
        tableview.reloadData()
    }
}
