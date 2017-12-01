////
////  BingoCollectionView.swift
////  StuffPeopleSay
////
////  Created by Michael Odere on 11/30/17.
////  Copyright © 2017 michaelodere. All rights reserved.
////
//
//import UIKit
//
//class BingoCollectionView: UICollectionView{
//    
//    var cards:[Card]?
//    let pieceTransparency:CGFloat = 0.2
//    var bingoGame:BingoGame = BingoGame()
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 25
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        if indexPath.row < cards.count{
//            let card = cards[indexPath.row]
//            self.gameStore.apiManager.updateBoard(boardCardId: card.boardCardId)
//            if card.active == 0{
//                self.gameStore.games[gameIndex].my.cards[indexPath.row].active = 1
//            }else{
//                self.gameStore.games[gameIndex].my.cards[indexPath.row].active = 0
//            }
//        }
//        
//        if let cell = collectionView.cellForItem(at: indexPath) as? BingoCollectionCell {
//            
//            let x = cell.xIndex!
//            let y = cell.yIndex!
//            
//            if cell.pieceView.alpha != pieceTransparency{
//                cell.pieceView.alpha = 0.0
//                bingoGame.board[x][y] = 0
//            }else{
//                cell.pieceView.alpha = pieceTransparency
//                bingoGame.board[x][y] = 1
//            }
//            
//            if (bingoGame.checkVictory(x: x, y: y)){
//                
//                self.gameStore.games[gameIndex].status = "ended"
//                self.gameStore.apiManager.updateGame(gameId: self.gameStore.games[gameIndex].gameId)
//                showAlert {
//                    self.bingoGame.boardReset()
//                    self.collectionView.reloadData()
//                    
//                }
//                
//            }
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BingoCell", for: indexPath) as! BingoCollectionCell
//        let card = cards[indexPath.row]
//        cell.backgroundColor = UIColor(red: 54/255.0, green: 80/255.0, blue: 98/255.0, alpha: 1.0)
//        
//        cell.title.text = card.name
//        
//        cell.xIndex = indexPath.row / 5
//        cell.yIndex = indexPath.row % 5
//        
//        cell.pieceView.addSubview(makeDrawnImageView(frame: cell.frame))
//        
//        if card.active == 1{
//            cell.pieceView.alpha = pieceTransparency
//            bingoGame.board[cell.xIndex][cell.yIndex] = 1
//            
//        }else{
//            cell.pieceView.alpha = 0.0
//        }
//        
//        
//        return cell
//    }
//    
//    func makeDrawnImageView(frame:CGRect)->UIView{
//        
//        let moveView:UIView = UIView(frame: frame)
//        let width = frame.size.width * 4 / 5
//        let imageView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
//        moveView.addSubview(imageView)
//        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal,
//                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
//        widthConstraint.isActive = true
//        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal,
//                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
//        heightConstraint.isActive = true
//        
//        let imageViewCenterX = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: moveView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
//        imageViewCenterX.isActive = true
//        
//        let imageViewCenterY = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: moveView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
//        imageViewCenterY.isActive = true
//        
//        let image = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: width), cornerRadius: width)
//        let shape = CAShapeLayer()
//        shape.path = image.cgPath
//        shape.fillColor = UIColor.red.cgColor
//        shape.strokeColor = UIColor.black.cgColor
//        
//        imageView.layer.addSublayer(shape)
//        
//        return imageView
//    }
//}

