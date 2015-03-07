//
//  API.swift
//  RailsRequest
//
//  Created by Michael McChesney on 2/17/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import Foundation

///////////
/////////// RAILS API
///////////

let API_URL = "https://team-managers.herokuapp.com"

typealias ResponseBlock = (responseInfo: [String:AnyObject]) -> ()

class APIRequest {
//    don't think this is being used
    class func requestWithEndPoint(endpoint: String, method: String, completion: ResponseBlock) {

    }
    
    class func requestWithOptions(options: [String:AnyObject], andCompletion completion: ResponseBlock)
    {
        
        var url = NSURL(string: API_URL + (options["endpoint"] as String))
        
        var request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = options["method"] as String

        
        switch request.HTTPMethod {
            
        case "GET" :
            
            url = NSURL(string: API_URL + (options["endpoint"] as String) + "?auth_token=" + User.currentUser().token!)
            
            request.URL = url
            
        case "POST" :
            
            ///// BODY
            
            let bodyInfo = options["body"] as [String:AnyObject]
            
            let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: .allZeros, error: nil)
            
            let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
            
            let postLength = "\(jsonString!.length)"
            
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            
            let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.HTTPBody = postData
            
        default :
            
            println(request.HTTPMethod)
            
        }
        
        
        ///// END BODY - now that it is setup, send the request
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in

            if error == nil {
                // do something with data
                
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    completion(responseInfo: json)
                    
                } else {
                    
                    println("no json")
                    
                }

                
            } else {
                println(error)
            }
   
        }
        
    }
    
}

    ///////////
    ///////////  USER CLASS / SINGLETON
    ///////////

private let _currentUser = User()

class User {
    
    // add email
    var email: String?
    // add user id
    var iD: Int?
    
    var token: String? {
        didSet {
            // save the token when it's set
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(token, forKey: "token")
            defaults.synchronize()
        }
    }
    
    init() {    // this fixes "no initializers" issue when creating the singleton. could do this or base class off NSObject.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        token = defaults.objectForKey("token") as? String
        
    }
    
    class func currentUser() -> User { return _currentUser }
    
    
    ///////////
    /////////// SIGN UP USER
    ///////////
    
    func getUserToken(email: String, andPassword password: String, andCompletion completion: () -> ()) {
        
        var options: [String:AnyObject] = [
        
            "endpoint" : "/users",
            "method" : "POST",
            "body" : [
            
                "user" : [ "email" : email, "password" : password ]
            
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            // do something after request is done

            println(responseInfo)
            if let userInfo = responseInfo["user"] as? [String:AnyObject] {
                // set token
                self.token = userInfo["authentication_token"] as String!
                println(userInfo)
                
                // set email
                self.email = userInfo["email"] as String!
                
                // set userID
                self.iD = userInfo["id"] as Int!
                
                completion()
            }
            
        })
        
    }
    
    ///////////
    /////////// LOG IN USER
    ///////////
    
    func logInUser(email: String, andPassword password: String, andCompletion completion: () -> ()) {
        
        println(email, password)
        
        var options: [String:AnyObject] = [
            
            "endpoint" : "/users/sign_in",
            "method" : "POST",
            "body" : [
                
                "user" : [ "email" : email, "password" : password ]
                
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            // do something after request is done
            
            println(responseInfo)
            
            if let userInfo = responseInfo["user"] as? [String:AnyObject] {
                // set token
                self.token = userInfo["authentication_token"] as String!

                // set email
                self.email = userInfo["email"] as String!
             
                completion()
            }

        })

    }
    
    
    ///////////
    /////////// REQUEST NEW GAME
    ///////////
    
    // Join GAME METHOD
//    func requestNewGame(completion: () -> ()) {
//        
//        var options: [String:AnyObject] = [
//            
//            "endpoint" : "games",
//            "method" : "PUT",
//            "body" : [
//                "auth_token" : token!
//            ]
//            
//        ]
//        
//        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
//            // do something after request is done
//            
//            println(responseInfo)
//            //create new game model and set data to response
//            
//            let newGame = GameModel()
////            newGame.boardSquares = responseInfo[]
//            
//            if let game = responseInfo["game"] as? [String:AnyObject] {
//                
//                if let board = game["board"] as? [[Int]] {
//            
//                    newGame.boardSquares = board
//                    
//                    DataModel.mainData().currentGame = newGame
//                    
//                    DataModel.mainData().allGames.append(newGame)   // necessary?
//                    
//                    completion()
//                    
//                }
//                
//            }
//            
//        })
//        
//        
//    }
    
    ///////////
    /////////// REQUEST GAME LIST
    ///////////
    
//    func requestGameList(completion: () -> ()) {
//        
//        println("request game list running...")
//        
//        var options: [String:AnyObject] = [
//            
//            "endpoint" : "games",
//            "method" : "GET",
//            "body" : [
//                "auth_token" : token!
//            ]
//            
//        ]
//        
//        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
//            // do something after request is done
//            
////            println(" request game list in api running: \(responseInfo)")
//            
//            let games = responseInfo["game"] as [[String:AnyObject]]
//            
//            for eachGame in games {
//                println(eachGame)
//                
//                let game = GameModel()
//                
//                ///////// GAME
//                let gm = eachGame["game"] as [String:AnyObject]
////                println(gm)
//                let board = gm["board"] as [[Int]]
////                println(board)
//                let id = gm["id"] as Int
////                println(id)
//                let lastUpdate: String? = gm["updated_at"] as? String
////                println(lastUpdate)
//                let turnCount: Int? = gm["turn_counter"] as? Int
////                println(turnCount)
//                let isFinished: Bool? = gm["finished"] as? Bool
////                println(isFinished)
//                
//                game.boardSquares = board
//                game.gameID = id
//                game.lastUpdate = lastUpdate
//                game.turnCount = turnCount
//                game.isFinished = isFinished
//                
//                game.players = []
//                
//                // ADD PLAYERS TO GAME
//                // PLAYER 2 - is this right? doubt it.
//                if let p2 = eachGame["player2"] as? [String:AnyObject] {
//                    //                    println(p2)
//
//                    let playerID = p2["id"] as Int
//                    let playerUsername = p2["username"] as String
//                    let direction = -1
//                    let player = Player(direction: direction)
//                    player.playerID = playerID
//                    player.playerUsername = playerUsername
//                    game.players.append(player)
//
//                }
//                // PLAYER 1
//                if let p1 = eachGame["player1"] as? [String:AnyObject] {
//                    //                    println(p2)
//                    
//                    let playerID = p1["id"] as Int
//                    let playerUsername = p1["username"] as String
//                    let direction = 1
//                    let player = Player(direction: direction)
//                    player.playerID = playerID
//                    player.playerUsername = playerUsername
//                    game.players.append(player)
//
//                }
//
//                // ADD GAME TO SINGLETON ARRAY
//                DataModel.mainData().allGames.append(game)
//                
//                completion()
//                
//            }
//            
//        })
//        
//    }
    
}