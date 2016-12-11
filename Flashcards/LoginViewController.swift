//
//  LoginViewController.swift
//  Mate
//
//  Created by Daniel Graf on 11/15/16.
//  Copyright © 2016 Ziyun Zheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FacebookCore
import FacebookLogin

/// First VC that the User sees. Logs into facebook from here
class LoginViewController: UIViewController, LoginButtonDelegate {
    
    /// A list of all users (id, facebook_id)
    var users:[(Int, Int)] = [(Int, Int)]()
    /// Email returned by Facebook. Obsolete at this point because turns out that it's optional
    var facebookEmail:String = String()
    /// ID returned by facebook. Used to store and create users.
    var facebook_id: Int = Int()
    /// Just the user ID
    var userId: Int = Int()
    
    // Stuff handled by Facebook
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        if case .cancelled = result {
            // Handle cancellations
        }
        else {
            // Navigate to other view
            checkFacebookEmail(accessToken: AccessToken.current!)

            let mainController = ContainerViewController()
            present(mainController, animated: true, completion: nil)
        }
    }
    
    // Useless. Won't log out at this screen
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    // Leaves keyboard. Obsolete after facebook
    @IBAction func backgroundTap(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    /**
     Login function. Just moves to the next view. Called after facebook login
     
     - Parameter token: The token facebook gives
    */
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
        
        // Creates login button created by facebook
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        loginButton.center.x = view.center.x
        loginButton.center.y = view.center.y+200
        loginButton.delegate = self
        
        view.addSubview(loginButton)

        // More Keyboard stuff. Obsolete.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    /**
     Gets all facebook info. Doesn't actually get just email, but that was the original name and we're sticking with it
     
     - Parameter accessToken: Facebook token
     
    */
    func checkFacebookEmail(accessToken: AccessToken) {
        
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start { (urlResponse, requestResult) in
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    guard let id = responseDictionary["id"] else {
                        print("ID error")
                        break
                    }
                    // Divide by 10million because FB_ID is too large
                    self.facebook_id = (Int(id as! String)!)/10000000
                    self.getUsers()
                }
            }
        }

    }
    
    /// Checks if the user exists, and either creates or gets the userID
    func checkIfUserExists() {
        let facebook_ids = self.users.map{$0.1}
        if let index = facebook_ids.index(of: self.facebook_id){
            print("contains")
            currentUserSetup(id: self.users[index].0, facebook_id: self.facebook_id)
        } else {
            print("create")
            createUser()
        }
        
    }
    
    /// Gets all of the users
    func getUsers() {
        Alamofire.request("https://morning-castle-56124.herokuapp.com/users").responseJSON {
            response in
            self.parseUsers(JSONData: response.data!)
        }
        
    }
    
    /// Parses the data from getUsers()
    func parseUsers(JSONData: Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! NSArray
            for i in 0..<readableJSON.count {
                var user = JSON(readableJSON[i])
                let id = user["id"].int
                let facebook_id = user["facebook_id"].int
                if facebook_id != nil {
                    self.users.append((id!, facebook_id!))
                }
            }
        }
        catch {
            print(error)
        }
        checkIfUserExists()
    }
    
    /// Creates the user if it wasn't found and sends it to the API
    func createUser() {
        let id = nextAvailableId()
        let parameters:Parameters = ["user": [
            "id": id,
            "facebook_id": self.facebook_id//"email\(id)@test.com" //Should be this facebook email, not test
            ]]
        let headers: HTTPHeaders = ["content-type": "application/json","accept": "application/json"]
        Alamofire.request("https://morning-castle-56124.herokuapp.com/users", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            //let statusCode = response.response?.statusCode
            //print(statusCode) //201 vs 500
        })
        
        currentUserSetup(id: id, facebook_id: facebook_id)
    }
    
    /**
     Sets up the user after being found or created
     
     - Parameter id: Takes the Users Id
     - Parameter facebook_id: Facebooks Ids
    */
    func currentUserSetup(id: Int, facebook_id: Int) {
        User.id = id
        User.facebook_id = facebook_id
        //User.friends = User.getUserFriends()
        User.getFullDecks()
    }
    
    /// Finds the next open User ID
    func nextAvailableId() -> Int {
        let ids = self.users.map{$0.0}
        var i = 3
        while true {
            if !ids.contains(i) {
                return i
            }
            i = i + 1
        }
    }

    // Changes the style to light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // Sets portrait mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
   
    // MARK: - Keyboard Moves Screen (obsolete)
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
    
    // Shouldn't go to landscape
    override var shouldAutorotate: Bool {
        return false
    }
}
