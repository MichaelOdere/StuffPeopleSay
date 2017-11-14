//
//  LoginViewController.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit
import PusherSwift

class LoginViewController:UIViewController{
    var pusher:Pusher!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var usernameTextfirled: UITextField!
    
    override func viewDidLoad() {
        print("view did load")
        let options = PusherClientOptions(
            host: .cluster("us2")
        )
        
        pusher = Pusher(
                key: "988d2b3b6aac9c80268b",
                options: options
        )
        
        // subscribe to channel and bind to event
        let channel = pusher.subscribe("my-channel")
        
        let _ = channel.bind(eventName: "my-event", callback: { (data: Any?) -> Void in
            if let data = data as? [String : AnyObject] {
                if let message = data["message"] as? String {
                    print("message")
                    print(message)
                }
            }
        })
        
        pusher.connect()
                
    }
    
    
}
