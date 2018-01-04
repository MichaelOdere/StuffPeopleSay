//
//  BoardCollectionViewCell.swift
//  StuffPeopleSay
//
//  Created by Michael Odere on 12/4/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var board:UICollectionView!
    var bingoDataSource:BingoCollectionView = BingoCollectionView()
    
    func setDelegation(){
        board.dataSource = bingoDataSource
        board.delegate = bingoDataSource
        
    }
}
