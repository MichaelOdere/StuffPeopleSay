//
//  GamesTableViewController.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/20/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit

class GamesTableViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var games:[Game] = []
    var apiManager:APIManager!
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell")
        
        cell?.textLabel?.text = games[indexPath.row].gameId
        cell?.detailTextLabel?.text = games[indexPath.row].status
        if games[indexPath.row].status.lowercased() == "ended"{
            cell?.backgroundColor = UIColor.green
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BingoController") as! BingoViewController
        
        vc.game = games[indexPath.row]
        vc.apiManager = self.apiManager

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
                self.apiManager.createCard(name: cardText)
            }
        })
        alert.addAction(add)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func newGame(_ sender: Any) {
        self.apiManager.createGame(completionHandler: { data, error in
            
            guard let data = data else {
                print(error as Any)
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let dictionary = json as? [String: Any] {
                print(dictionary)
                if let game = Game(json: dictionary){
                    self.games.insert(game, at: 0)
                    print("New game added")
                }
                
                print(self.games.count)
                DispatchQueue.main.sync {
                    self.tableview.reloadData()
                }
                
                
            }
            
        })
    }
}
