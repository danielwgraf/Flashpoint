//
//  DeckViewController.swift
//  Flashcards
//
//  Created by Daniel Graf on 11/16/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import UIKit

class DeckViewController: UIViewController {
    
    @IBAction func checkLogOut(_ sender: AnyObject) {
        let logoutAlertController = UIAlertController(title: "Log Out", message: "Are you sure that you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        logoutAlertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default,handler: nil))
        logoutAlertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: {(alert: UIAlertAction!) in self.logout()}))
        self.present(logoutAlertController, animated: true, completion: nil)

    }
    
    func logout () {
        // Create a new "Main Storyboard" instance.
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        // Create an instance of the storyboard's initial view controller.
        let loginController = storyboard.instantiateViewController(withIdentifier: "Login") as UIViewController
        
        present(loginController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
