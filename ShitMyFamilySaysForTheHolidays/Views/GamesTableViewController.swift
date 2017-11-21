//
//  GamesTableViewController.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/20/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit

class GamesTableViewController:UITableViewController{
    
    var games:[Game] = []
    var apiManager:APIManager!

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell")
        
        cell?.textLabel?.text = games[indexPath.row].gameId
        cell?.detailTextLabel?.text = games[indexPath.row].status

        return cell!
    }
}
