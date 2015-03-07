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
        
        
    }
    
    @IBAction func addEvent(sender: AnyObject) {
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
