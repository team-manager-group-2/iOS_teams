//
//  NewGameTVC.swift
//  PlayerHaters
//
//  Created by Michael McChesney on 3/7/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class NewGameTVC: UITableViewController {

    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var eventTypeControl: UISegmentedControl!
    @IBOutlet weak var opponentField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var eventTimePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    @IBAction func gameStatusChanged(sender: UISwitch) {
        
        if sender.on {
            gameStatusLabel.text = "Active"
        } else {
            gameStatusLabel.text = "Cancelled"
        }
        
    }
    
    @IBAction func addEvent(sender: AnyObject) {
        
        // add the event to the singleton
        var eventType = ""
        switch eventTypeControl.selectedSegmentIndex {
        case 0:
            eventType = eventTypeControl.titleForSegmentAtIndex(0)!
        case 1:
            eventType = eventTypeControl.titleForSegmentAtIndex(1)!
        default:
            println("?")
        }
        
        let eventDate = dateToString()
        
//        let newEvent = [
//            "status" : gameStatusLabel.text,
//            "type" : eventType,
//            "opponent" : opponentField.text,
//            "location" : locationField.text,
//            "time" : eventDate
//        ] as [String:String]
        

//        AppData.mainData().schedule.append(newEvent)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func dateToString() -> String {
        
        let date: NSDate = eventTimePicker.date
        
        let dateFormatter = NSDateFormatter()
        
        var theDateFormat = NSDateFormatterStyle.ShortStyle
        let theTimeFormat = NSDateFormatterStyle.ShortStyle
        
        dateFormatter.dateStyle = theDateFormat
        dateFormatter.timeStyle = theTimeFormat
        
        return dateFormatter.stringFromDate(date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
