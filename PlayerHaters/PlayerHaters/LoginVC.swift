//
//  LoginVC.swift
//  Chime
//
//  Created by Max McChesney on 3/2/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////////
        /////////   SHIFT UI WITH KEYBOARD PRESENT
        /////////
        var keyboardHeight: CGFloat = 0
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification: NSNotification!) -> Void in
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                // move constraint
                keyboardHeight = kbSize.height
                self.loginBottomConstraint.constant += keyboardHeight
                self.signUpConstraint.constant += keyboardHeight

                // animate constraint
                self.view.layoutIfNeeded()
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            // move constraint back
            self.loginBottomConstraint.constant -= keyboardHeight
            self.signUpConstraint.constant -= keyboardHeight

            // animate constraint
            self.view.layoutIfNeeded()
        } // end: keyboard shift
        

    }  // end: viewDidLoad

    /////////
    /////////   LOG IN / SIGN UP
    /////////
    func checkField() {
       
        var fieldValues: [String] = [emailField.text,passwordField.text]
        if find(fieldValues, "") != nil {
            // all fields are not filled in, present alert
            var alertViewController = UIAlertController(title: "Submission Error", message: "Please fill in all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertViewController.addAction(defaultAction)
            presentViewController(alertViewController, animated: true, completion: nil)
        } else {
            // all fields are filled in, check if user exists
            
        }
        
        
    }
        // email / pw field validation
    
    @IBAction func signUp(sender: AnyObject) {
//    sign up user
        
    }

    @IBAction func logIn(sender: AnyObject) {
//    log in user
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // dismiss keyboard when user touches outside textfields
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)   // ?? is this necessary
    }

} // end: viewController






