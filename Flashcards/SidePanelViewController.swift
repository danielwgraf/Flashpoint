//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit


protocol SidePanelViewControllerDelegate {
  //func animalSelected(_ animal: Animal)
}

class SidePanelViewController: UIViewController {
    
    @IBAction func checkLogOut(_ sender: AnyObject) {
        let logoutAlertController = UIAlertController(title: "Log Out", message: "Are you sure that you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        logoutAlertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default,handler: nil))
        logoutAlertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: {(alert: UIAlertAction!) in self.logout()}))
        self.present(logoutAlertController, animated: true, completion: nil)
        
    }
    
    func logout () {
        self.presentingViewController!.dismiss(animated: true, completion: nil);
//        // Create a new "Main Storyboard" instance.
//        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        
//        // Create an instance of the storyboard's initial view controller.
//        let loginController = storyboard.instantiateViewController(withIdentifier: "Login") as UIViewController
//        
//        present(loginController, animated: true, completion: nil)
    }
  
    var delegate: SidePanelViewControllerDelegate?
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
}
