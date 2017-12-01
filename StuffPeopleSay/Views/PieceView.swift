//
//  PieceView.swift
//  StuffPeopleSay
//
//  Created by Michael Odere on 11/30/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit

class PieceView: UIView{
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.size.width)
        UIColor.red.setFill()
        path.fill()
    }
}
