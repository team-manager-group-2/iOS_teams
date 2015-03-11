//
//  AllTeamsTVC.swift
//  PlayerHaters
//
//  Created by Michael McChesney on 3/6/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class AllTeamsTVC: UITableViewController {

    var teams = [["":""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        checkIfLoggedIn()
        
        teams = AppData.mainData().allTeams
        tableView.reloadData()
    }
    
    func checkIfLoggedIn() {
        
        // check for existing token - move to VIEWDIDLOAD or ViewdidAppear?
        if let token = User.currentUser().token {
            println("User exists and is logged in with auth token: \(token)")
            
        } else {
            
            // go to LogInViewController
            if let loginVC = storyboard?.instantiateViewControllerWithIdentifier("loginVC") as? LoginVC {
                navigationController?.presentViewController(loginVC, animated: false, completion: nil)
            }
            
        }

    }
    
    @IBAction func logOut(sender: AnyObject) {
        
        // log out
        User.currentUser().token = nil
        User.currentUser().email = nil
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("token")
        
        // go to LogInViewController
        if let loginVC = storyboard?.instantiateViewControllerWithIdentifier("loginVC") as? LoginVC {
            navigationController?.presentViewController(loginVC, animated: true, completion: nil)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return teams.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("allTeamsCell", forIndexPath: indexPath) as UITableViewCell

        // set title labels to team name and either a) coach name, or b) # of players
        let team = teams[indexPath.row]
        let name = team["teamName"]
        let coach = team["coachName"]
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = "Coach \(coach!)"
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // user selected a team, push the rosterTVC
        
        
        let tabBarVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarVC") as UITabBarController
        
        self.navigationController?.presentViewController(tabBarVC, animated: true, completion: nil)
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            teams.removeAtIndex(indexPath.row)
            AppData.mainData().allTeams.removeAtIndex(indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            

            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
