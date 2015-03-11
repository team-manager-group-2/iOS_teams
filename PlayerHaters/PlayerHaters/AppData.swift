//
//  AppData.swift
//  PlayerHaters
//
//  Created by Michael McChesney on 3/7/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

let _mainData: AppData = AppData()

class AppData: NSObject {
//   singleton
    

    var allTeams = [
        
        [
            "teamName":"Dawgs",
            "sport":"Football",
            "coachName":"Mark Richt",
            "homeField":"Athens"
        ],
        [
            "teamName":"Yellow Jackets",
            "sport":"Coding",
            "coachName":"Billy Madison",
            "homeField":"Decatur"
        ],
        [
            "teamName":"Braves",
            "sport":"Baseball",
            "coachName":"Andy Doyle",
            "homeField":"Atlanta"
        ],
        [
            "teamName":"Hornets",
            "sport":"Hockey",
            "coachName":"Catfish Andy",
            "homeField":"Charlotte"
        ],
        [
            "teamName":"Steelers",
            "sport":"Baseball",
            "coachName":"Thomas Hill",
            "homeField":"Decatur"
        ]
        
    ]
    
    var roster = [
        
        [
            "playerName":"Ole' Catfish Andy",
            "parent1":"Cat",
            "parent2":"Fish",
            "position":"Catcher",
            "age":"30"
        ],
        [
            "playerName":"Gato DeLaNoche",
            "parent1":"Evana",
            "parent2":"Paul",
            "position":"Pitcher",
            "age":"42"
        ],
        [
            "playerName":"Snax McCheesenuts",
            "parent1":"Kramer",
            "parent2":"Elaine",
            "position":"Owner",
            "age":"27"
        ]
    ]
    
    var schedule = [
        
        [
            "status":"active",
            "type":"Game",
            "opponent":"Jo",
            "location":"Chastain Field",
            "time":"4/20/15, 5:00pm"
        ],
        [
            "status":"cancelled",
            "type":"Practice",
            "opponent":"UGA",
            "location":"Falcon's Stadium",
            "time":"4/13/15, 3:00pm"
        ],
        [
            "status":"active",
            "type":"Game",
            "opponent":"Kentucky",
            "location":"Around Back",
            "time":"4/5/15, 12:00pm"
        ],
        
    ]

    
    
    class func mainData() -> AppData {
        
        return _mainData
        
    }
}
