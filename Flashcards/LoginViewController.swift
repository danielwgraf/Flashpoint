//
//  LoginViewController.swift
//  Mate
//
//  Created by Daniel Graf on 11/15/16.
//  Copyright © 2016 Ziyun Zheng. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    
    // Username
    @IBOutlet weak var username: UITextField!
    
    // Password
    @IBOutlet weak var password: UITextField!
    
    
    // Log in function when button is pressed
    @IBAction func loginButtonAction(sender: AnyObject) {
        //Success Variable for when logging in
        print("\n\n\n\nAccess:",AccessToken.current,"\n\n\n\n")
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            login(token: accessToken)
        } else {
            print("\n\n\n\nFAILED :( \n\n\n\n")
        }
//        var success = 0
//        
//        // Create the alert box for failed log in
//        let alertController = UIAlertController(title: "Login Failed!", message: "Error: Should not see this text!", preferredStyle: UIAlertControllerStyle.alert)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
//        
//        // Create a new "Main Storyboard" instance.
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        // Create an instance of the storyboard's initial view controller.
//        let mainController = ContainerViewController()
////        let navController = storyboard.instantiateViewController(withIdentifier: "Nav") as! UINavigationController
//        do {
//            if self.username.text! == "" || self.password.text! == "" {
//        
//                alertController.message = "Please enter Email and Password"
//                
//                self.present(alertController, animated: true, completion: nil)
//            } else {
//                //let serverAgent = ServerAgent(username: username.text!, password: password.text!)
//                //print(serverAgent.authToken)
//                
//                
//                //temp login
//                if username.text! == "test" && password.text! == "pass" {
//                    success = 1
//                } else {
//                    alertController.message = "Incorrect Login"
//                    
//                    self.present(alertController, animated: true, completion: nil)
//                }
//            }
//            
//        } //catch (NSException) {
//        
//        if success == 1 {
//            present(mainController, animated: true, completion: nil)
//        }

    }
    
    @IBAction func backgroundTap(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func login(token: AccessToken) {
        let mainController = ContainerViewController()
        present(mainController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            login(token: accessToken)
        }
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        print("\n\n\n\nAccessToken:",AccessToken.current,"\n\n\n\n")
        

        self.username.delegate = self
        self.password.delegate = self
        
        // Don't need these, but saving for the syntax
//        username.addTarget(self, action: #selector(usernameFocus(textField:)), for: UIControlEvents.touchDown)
//        password.addTarget(self, action: #selector(passwordFocus(textField:)), for: UIControlEvents.touchDown)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.username {
            username.resignFirstResponder()
            password.becomeFirstResponder()
        } else {
            password.resignFirstResponder()
            loginButtonAction(sender: textField)
        }
        return true
    }
    
    
    // MARK: - Keyboard Moves Screen
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
