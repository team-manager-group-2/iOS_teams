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

        if let token = User.currentUser().token {
            request.setValue(token, forHTTPHeaderField: "authentication-token")
        }

        
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
            
                "user" : [ "email" : email, "password" : password, "type" : "Manager" ]
            
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
    /////////// CREATE NEW TEAM
    ///////////
    

    func createNewTeam(teamName: String, andSport sport: String, andCoachName coachName: String, andHomeField homeField: String, andCompletion completion: () -> ()) {
        
        println(teamName, sport)
        
        var options: [String:AnyObject] = [
            
            "endpoint" : "/teams",
            "method" : "POST",
            "body" : [
                
                "team" : [ "name" : teamName, "sport" : sport, "coach_name" : coachName, "homefield" : homeField ]
                
            ]
            
        ]
        
        println(options)
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            // do something after request is done
            
            println("response: \(responseInfo)")
            
//            if let userInfo = responseInfo["user"] as? [String:AnyObject] {
//                // set token
//                self.token = userInfo["authentication_token"] as String!
//                
//                // set email
//                self.email = userInfo["email"] as String!
//                
//                completion()
//            }
            
        })
        
    }
    
}