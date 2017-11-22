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
    var game:Game!
    var apiManager:APIManager!
    var pushManager:PusherManager!

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    
    let arr = Array(0...24)
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self

        tableview.dataSource = self
        tableview.delegate = self

        bingoGame = BingoGame()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        playing , ended posibled statuses
        if game.status.lowercased() != "playing"{
            return
        }
        
        if indexPath.row < game.cards.count{
            let card = game.cards[indexPath.row]
            self.apiManager.updateBoard(boardCardId: card.boardCardId)
            if card.active == 0{
                game.cards[indexPath.row].active = 1
            }else{
                game.cards[indexPath.row].active = 0
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
            
            print(bingoGame.board)
            if (bingoGame.checkVictory(x: x, y: y)){
               
                game.status = "ended"
                self.apiManager.updateGame(gameId: game.gameId)
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
        let card = game.cards[indexPath.row]
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
}
extension BingoViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("HERE IN TABLEVIEW")
        return self.game.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user =  self.game.users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")
        
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text =  "Cards active: " + String(user.cardsActiveCount)
        
        return cell!
    }
}
