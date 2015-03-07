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
    
    var teams = [:]
    
    class func mainData() -> AppData {
        
        return _mainData
        
    }
}
