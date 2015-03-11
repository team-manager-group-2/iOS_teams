//
//  NewPlayerTVC.swift
//  PlayerHaters
//
//  Created by Michael McChesney on 3/6/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class NewPlayerTVC: UITableViewController {
    
    @IBOutlet weak var playerNameField: UITextField!
    @IBOutlet weak var parent1Field: UITextField!
    @IBOutlet weak var parent2Field: UITextField!
    @IBOutlet weak var positionField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    func dateToAge() -> NSInteger {
        // birthday picker converted to age
        
        var birthday: NSDate = birthdayPicker.date
        
        var now = NSDate()
        
        var currentCalender = NSCalendar.currentCalendar()
        
        let ageCompenents: NSDateComponents = currentCalender.components(NSCalendarUnit.YearCalendarUnit, fromDate: birthday, toDate: now, options: NSCalendarOptions.allZeros)
        
        
        let age: NSInteger = ageCompenents.year
        
        return age
        
    }
    
    
    @IBAction func addPlayer(sender: AnyObject) {
        
        // textfield validation
        var fieldValues: [String] = []
        fieldValues = [playerNameField.text,parent1Field.text, positionField.text]
        if find(fieldValues, "") != nil {
            // all fields are not filled in, present alert
            var alertViewController = UIAlertController(title: "Great Scott!", message: "Please fill in all required fields.", preferredStyle: UIAlertControllerStyle.Alert)
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertViewController.addAction(defaultAction)
            presentViewController(alertViewController, animated: true, completion: nil)
        } else {
            
            // add new player
            
            let newPlayer = [
                "playerName":playerNameField.text,
                "parent1":parent1Field.text,
                "parent2":parent2Field.text,
                "position":positionField.text,
                "age":"age: \(String(dateToAge()))"
                ] as [String:String]
            
            AppData.mainData().roster.append(newPlayer)
            // new game is saved, go back to allTeamsTVC
            navigationController?.popViewControllerAnimated(true)
            
        }

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let playerDetailTVC = self.storyboard?.instantiateViewControllerWithIdentifier("playerDetailTVC") as PlayerDetailTVC
        self.navigationController?.pushViewController(playerDetailTVC, animated: true)
        
    }
    
}
