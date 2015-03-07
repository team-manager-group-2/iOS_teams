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
            "teamName":"MyCouchPullsOutButIDon't",
            "sport":"Playin'",
            "coachName":"Ole' Catfish Andy",
            "homeField":"Decatur"
        ],
        [
            "teamName":"BeatsByRay",
            "sport":"Playin'",
            "coachName":"Ole' Catfish Andy",
            "homeField":"Decatur"
        ],
        [
            "teamName":"StitchedBalls",
            "sport":"Playin'",
            "coachName":"Ole' Catfish Andy",
            "homeField":"Decatur"
        ],
        [
            "teamName":"MyCouchPullsOutButIDon't",
            "sport":"Playin'",
            "coachName":"Ole' Catfish Andy",
            "homeField":"Decatur"
        ],
        [
            "teamName":"MyCouchPullsOutButIDon't",
            "sport":"Playin'",
            "coachName":"Ole' Catfish Andy",
            "homeField":"Decatur"
        ]
        
    ]
    
    var roster = [
        
        [
            "playerName":"Catfish Andy",
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

    
    
    class func mainData() -> AppData {
        
        return _mainData
        
    }
}
