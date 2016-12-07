//
//  LoginViewController.swift
//  Mate
//
//  Created by Daniel Graf on 11/15/16.
//  Copyright © 2016 Ziyun Zheng. All rights reserved.
//

import UIKit
import Alamofire
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController, LoginButtonDelegate {
    
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        if case .cancelled = result {
            // Handle cancellations
        }
        else {
            // Navigate to other view
            checkFacebookEmail(accessToken: AccessToken.current!)
            //works just commenting out
//            let parameters:Parameters = ["user": [
//                "id": 3,
//                "email": "grafmark59@gmail.com"
//                ]]
//            let headers: HTTPHeaders = ["content-type": "application/json","accept": "application/json"]
//            Alamofire.request("https://morning-castle-56124.herokuapp.com/users", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
//                var statusCode = response.response?.statusCode
//                print(statusCode) //201 vs 500
            
                
//                if (statusCode == 200){
//                    self.setAuthToken(JSONData: response.data!)
//                    UserDefaults.standard.set(email, forKey: "email")
//                    UserDefaults.standard.set(password, forKey: "password")
//                    let controller = ContainerViewController()
//                    self.present(controller, animated: true, completion: nil)
//                }
//                else if (statusCode == 401){
//                    // Create the alert box for failed log in
//                    let alertController = UIAlertController(title: "Login Failed!", message: "Error: Should not see this text!", preferredStyle: UIAlertControllerStyle.alert)
//                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
//                    alertController.message = "incorrect username or password"
//                    self.present(alertController, animated: true, completion: nil)
//                }
            //})

            let mainController = ContainerViewController()
            present(mainController, animated: true, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
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
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton.center.x = view.center.x
        loginButton.center.y = view.center.y+200
        loginButton.delegate = self
        
        view.addSubview(loginButton)
                
        // Don't need these, but saving for the syntax
//        username.addTarget(self, action: #selector(usernameFocus(textField:)), for: UIControlEvents.touchDown)
//        password.addTarget(self, action: #selector(passwordFocus(textField:)), for: UIControlEvents.touchDown)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        
    }
    
    func checkFacebookEmail(accessToken: AccessToken) {
        
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start { (urlResponse, requestResult) in
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    guard let email = responseDictionary["email"] else {
                        print("Email error")
                        break
                    }
                    self.checkIfUserExists(email: email as! String)
                }
            }
        }

    }
    
    func checkIfUserExists(email: String) {
        //            let parameters:Parameters = ["user": [
        //                "id": 3,
        //                "email": "grafmark59@gmail.com"
        //                ]]
        //            let headers: HTTPHeaders = ["content-type": "application/json","accept": "application/json"]
        //            Alamofire.request("https://morning-castle-56124.herokuapp.com/users", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
        //                var statusCode = response.response?.statusCode
        //                print(statusCode) //201 vs 500
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
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
