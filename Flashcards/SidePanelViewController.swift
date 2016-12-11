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
    func segueToCards()
    func closePanels()
}

/// Side panel stuff
class SidePanelViewController: UIViewController, LoginButtonDelegate {
    
    // Delegate stuff. Don't use the second
    var delegate: SidePanelViewControllerDelegate?
    var delegate2: SidePanelViewControllerDelegate?
    
    /// Allows user to see friends (not implemented from facebook stuff)
    @IBAction func SeeFriends(_ sender: Any) {
        
    }
    
    /// Move to cards
    @IBAction func viewCards(_ sender: AnyObject) {
        delegate?.closePanels()
        delegate?.segueToCards()
    }
    
    ///Does the delete function (and chooses based on deck center view and card center view)
    @IBAction func deleteDeck(_ sender: AnyObject) {
        if UIApplication.shared.keyWindow!.rootViewController?.presentedViewController is ContainerViewController {
            let containView = UIApplication.shared.keyWindow!.rootViewController!.presentedViewController as! ContainerViewController
            let navController = containView.centerNavigationController
            if navController != nil {
                if navController?.visibleViewController is CardCenterViewController {
                    print("Card")
                } else {
                    print("deck")
                }
            }
        }
        print(delegate is CenterViewController)
        //if delegate is
    }
    
    // Load stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoutButtonFrame = CGRect(x: 0, y: 0, width: 85, height: 30)
        let logoutButton = LoginButton(frame: logoutButtonFrame, readPermissions: [ .publicProfile ])
        
        logoutButton.center.x = view.center.x*0.4
        logoutButton.center.y = view.center.y+275
        
        logoutButton.delegate = self
        
        view.addSubview(logoutButton)
    }
    
    // Useless cause you don't login from the app
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
    }
    
    // Logs out. Yay
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        logout()
        self.presentingViewController!.dismiss(animated: true, completion: nil);
    }
    
    // Actually logs out
    func logout() {
        FBSDKLoginManager().logOut()
    }
  
}
