//
//  User.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import Foundation

class User{
    var id:String!
    var name:String!
    var cardsActiveCount:Int!
    init(id: String, name: String, cardsActiveCount:Int) {
        self.id = id
        self.name = name
        self.cardsActiveCount = cardsActiveCount
    }
    
    
}

