//
//  BingoViewController.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/13/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit

class BingoViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    var game:BingoGame!
    var pushManager:PusherManager!
    
    @IBOutlet var collectionView: UICollectionView!

    let arr = Array(0...24)
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        game = BingoGame()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BingoCollectionCell {

            let x = cell.xIndex!
            let y = cell.yIndex!
            
            if cell.pieceImage.image != nil{
                cell.pieceImage.image = nil
                
                game.board[x][y] = 0
            }else{
                let image = UIImage(named: "bingo_piece.png")
                cell.pieceImage.image = image
                cell.pieceImage.alpha = 0.6
           
                game.board[x][y] = 1
            }
            
            print(game.board)
            if (game.checkVictory(x: x, y: y)){
               
                showAlert {
                    self.game.boardReset()
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
        
        cell.backgroundColor = UIColor(red: 54/255.0, green: 80/255.0, blue: 98/255.0, alpha: 1.0)
    
        cell.title.text = "This is my title"
        cell.pieceImage.image = nil
        
        cell.xIndex = indexPath.row / 5
        cell.yIndex = indexPath.row % 5
        
        return cell
    }
    
    @IBAction func logoutNavBar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
