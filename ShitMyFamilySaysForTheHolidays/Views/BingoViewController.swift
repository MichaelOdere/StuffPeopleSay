//
//  BingoViewController.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/13/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit

class BingoViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    var bingoGame:BingoGame!
    var gameIndex:Int!
    var gameStore:GameStore!
    var pushManager:PusherManager!

    var loadingView:UIActivityIndicatorView!

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        
        loadingView = UIActivityIndicatorView(frame: self.view.frame)
        loadingView.backgroundColor = UIColor.gray
        loadingView.layer.opacity = 0.8
        
        collectionView.dataSource = self
        collectionView.delegate = self

        tableview.dataSource = self
        tableview.delegate = self

        bingoGame = BingoGame()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(BingoViewController.didBecomeActive),
                                               name: Notification.Name("didBecomeActive"),
                                               object: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        playing , ended posibled statuses
        if self.gameStore.games[gameIndex].status.lowercased() != "playing"{
            return
        }
        
        if indexPath.row < self.gameStore.games[gameIndex].cards.count{
            let card = self.gameStore.games[gameIndex].cards[indexPath.row]
            self.gameStore.apiManager.updateBoard(boardCardId: card.boardCardId)
            if card.active == 0{
                self.gameStore.games[gameIndex].cards[indexPath.row].active = 1
            }else{
                self.gameStore.games[gameIndex].cards[indexPath.row].active = 0
            }
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? BingoCollectionCell {

            let x = cell.xIndex!
            let y = cell.yIndex!
            
            if cell.pieceImage.image != nil{
                cell.pieceImage.image = nil
                
                bingoGame.board[x][y] = 0
            }else{
                let image = UIImage(named: "bingo_piece.png")
                cell.pieceImage.image = image
                cell.pieceImage.alpha = 0.6
           
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BingoCell", for: indexPath) as! BingoCollectionCell
        let card = self.gameStore.games[gameIndex].cards[indexPath.row]
        cell.backgroundColor = UIColor(red: 54/255.0, green: 80/255.0, blue: 98/255.0, alpha: 1.0)
    
        cell.title.text = card.name
        
        cell.xIndex = indexPath.row / 5
        cell.yIndex = indexPath.row % 5
        
        if card.active == 1{
            let image = UIImage(named: "bingo_piece.png")
            cell.pieceImage.image = image
            cell.pieceImage.alpha = 0.6
            bingoGame.board[cell.xIndex][cell.yIndex] = 1

        }else{
            cell.pieceImage.image = nil

        }
        return cell
    }
    
    @IBAction func logoutNavBar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didBecomeActive(){
        var oldGameId = self.gameStore.games[gameIndex].gameId
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
        cell?.detailTextLabel?.text =  "Cards active: " + String(user.cardsActiveCount)
        
        return cell!
    }
}
