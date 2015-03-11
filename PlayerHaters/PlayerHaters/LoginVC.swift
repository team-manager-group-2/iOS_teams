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
    @IBOutlet weak var brandTopLabel: UILabel!
    @IBOutlet weak var brandBottomLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var brandConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////////
        /////////   SHIFT UI WITH KEYBOARD PRESENT
        /////////
        
        var originalConstraint: CGFloat = self.loginBottomConstraint.constant
        var brandOriginalConstraint: CGFloat = self.brandConstraint.constant
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification: NSNotification!) -> Void in
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                // move constraint
                println("keyboard height: \(kbSize.height)")
                let keyboardHeight = kbSize.height
                self.loginBottomConstraint.constant = keyboardHeight
                self.signUpConstraint.constant = keyboardHeight

                self.brandBottomLabel.hidden = true
                self.brandTopLabel.hidden = true
                
                self.brandConstraint.constant = brandOriginalConstraint + 95
                
                // animate constraint
                self.view.layoutIfNeeded()
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            // move constraint back
            self.loginBottomConstraint.constant = originalConstraint
            self.signUpConstraint.constant = originalConstraint

            self.brandBottomLabel.hidden = false
            self.brandTopLabel.hidden = false
            
            self.brandConstraint.constant = brandOriginalConstraint
            
            // animate constraint
            self.view.layoutIfNeeded()
        } // end: keyboard shift
        

    }  // end: viewDidLoad

    
    /////////
    /////////   LOG IN / SIGN UP
    /////////
    
    var fieldValues: [String] = []
    func checkFields(completion: () -> ()) {
       // textfield validation
        fieldValues = [emailField.text,passwordField.text]
        if find(fieldValues, "") != nil {
            // all fields are not filled in, present alert
            var alertViewController = UIAlertController(title: "Submission Error", message: "Please fill in all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertViewController.addAction(defaultAction)
            presentViewController(alertViewController, animated: true, completion: nil)
        } else {
            // all fields are filled in, check if user exists
      
            completion()
        
        }
     
    }
    
    // sign up user
    @IBAction func signUp(sender: AnyObject) {

        // check that fields are filled out
        checkFields { () -> () in
            
            println("Sign up btn pressed, getting user token...")
            
            User.currentUser().getUserToken(self.emailField.text, andPassword: self.passwordField.text, andCompletion: { () -> () in
                // fields are good, sign up user
                println("User signed in, dismissing VC...")
                
                // dismiss view controller when finished
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })

        }
        
    }

    // log in user
    @IBAction func logIn(sender: AnyObject) {

        // check that fields are filled out
        checkFields { () -> () in
            
            println("Fields are good, logging in user...")
            
            User.currentUser().logInUser(self.emailField.text, andPassword: self.passwordField.text, andCompletion: { () -> () in
                
                println("User logged in succesfully, dismissing VC...")
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })
            
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // dismiss keyboard when user touches outside textfields
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)   // ?? is this necessary
    }

} // end: viewController






