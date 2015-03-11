//
//  CustomNavController.swift
//  PlayerHaters
//
//  Created by Michael McChesney on 3/8/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class CustomNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bgView = DesignableView()
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)

        bgView.topColor = UIColor(red:0.71, green:0.93, blue:0.32, alpha:1)
        bgView.bottomColor = UIColor(red:0.26, green:0.58, blue:0.13, alpha:1)
        view.insertSubview(bgView, atIndex: 1)
//
//        
//        
//        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        //        self.navigationBar.shadowImage = UIImage()
//        self.navigationBar.backgroundColor = UIColor.clearColor()
//        self.navigationBar.tintColor = UIColor.whiteColor()
//        self.navigationBar.backgroundColor = UIColor(red:0.42, green:0.71, blue:0.2, alpha:1)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
