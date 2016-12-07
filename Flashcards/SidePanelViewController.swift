//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit



protocol SidePanelViewControllerDelegate {
  //func animalSelected(_ animal: Animal)
}

class SidePanelViewController: UIViewController, LoginButtonDelegate {
    
    @IBAction func checkLogOut(_ sender: AnyObject) {
        let logoutAlertController = UIAlertController(title: "Log Out", message: "Are you sure that you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        logoutAlertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default,handler: nil))
        logoutAlertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: {(alert: UIAlertAction!) in self.logout()}))
        self.present(logoutAlertController, animated: true, completion: nil)
        
    }
    
    
    var delegate: SidePanelViewControllerDelegate?
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoutButtonFrame = CGRect(x: 0, y: 0, width: 85, height: 30)
        let logoutButton = LoginButton(frame: logoutButtonFrame, readPermissions: [ .publicProfile ])
        
        logoutButton.center.x = view.center.x*0.4
        logoutButton.center.y = view.center.y+275
        
        logoutButton.delegate = self
        
        view.addSubview(logoutButton)
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        logout()
        self.presentingViewController!.dismiss(animated: true, completion: nil);
    }
    
    func logout() {
        FBSDKLoginManager().logOut()
    }
  
}
