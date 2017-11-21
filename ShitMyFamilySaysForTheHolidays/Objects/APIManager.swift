//
//  APIManager.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/20/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import Foundation

class APIManager{
    
    var isLoggedIn:Bool = false
    
    var token:String!
    var socketId:String!

    private let baseURL = "https://692188cd-b52e-4eef-8712-6b069331e1d9.now.sh"

    init(token: String?, socketId: String) {
        self.token = token
        self.socketId = socketId

        if token != nil{
            isLoggedIn = true
        }
    }
    
    func getUser(email:String, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        let url = URL(string: baseURL + "/users/auth")!
        var request = URLRequest(url: url)
        request.httpBody = "{\"email\" : \"\(email)\"}".data(using: .utf8)
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
        
        task.resume()
        
    }
    
    func getGames(completionHandler: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: baseURL + "/games")!
        var request = URLRequest(url: url)

        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
        
        task.resume()
        
    }

    func createGame(completionHandler: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: baseURL + "/games")!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")

        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
        
        task.resume()
        
    }

    func updateBoard(boardCardId: String){
        let url = URL(string: baseURL + "/boards/" + boardCardId)!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                print(dictionary)
            }
        }
        
        task.resume()
    }
    
    func updateGame(gameId: String){
        
    
        let url = URL(string: baseURL + "/games/" + gameId )!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"winner\" : \"true\"}".data(using: .utf8)

        request.httpMethod = "PUT"

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                print(dictionary)
            }
        }
        
        task.resume()
    }
    
    func createCard(name: String){
        let url = URL(string: baseURL + "/cards")!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = "{\"name\" : \"\(name)\"}".data(using: .utf8)
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                print(dictionary)
            }
        }
        
        task.resume()
    }
    
    // Update board
    // Update a game
}
