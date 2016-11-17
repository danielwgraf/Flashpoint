//
//  LoginViewController.swift
//  Mate
//
//  Created by Daniel Graf on 11/15/16.
//  Copyright © 2016 Ziyun Zheng. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // Username
    @IBOutlet weak var username: UITextField!
    
    // Password
    @IBOutlet weak var password: UITextField!
    
    
    // Log in function when button is pressed
    @IBAction func loginButtonAction(sender: AnyObject) {
        //Success Variable for when logging in
        var success = 0
        
        // Create the alert box for failed log in
        let alertController = UIAlertController(title: "Login Failed!", message: "Error: Should not see this text!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        // Create a new "Main Storyboard" instance.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Create an instance of the storyboard's initial view controller.
        let controller = storyboard.instantiateViewController(withIdentifier: "DeckListViewController") as UIViewController
        do {
            if self.username.text! == "" || self.password.text! == "" {
        
                alertController.message = "Please enter Email and Password"
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                //let serverAgent = ServerAgent(username: username.text!, password: password.text!)
                //print(serverAgent.authToken)
                
                
                //temp login
                if username.text! == "test" && password.text! == "pass" {
                    success = 1
                } else {
                    alertController.message = "Incorrect Login"
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        } //catch (NSException) {
        
        if success == 1 {
            present(controller, animated: true, completion: nil)
        }
 
//        NSInteger success = 0;
//        @try {
//            
//            if([[self.txtUsername text] isEqualToString:@""] || [[self.txtPassword text] isEqualToString:@""] ) {
//                
//                [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
//                
//            } else {
//                NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@",[self.txtUsername text],[self.txtPassword text]];
//                NSLog(@"PostData: %@",post);
//                
//                NSURL *url=[NSURL URLWithString:@"https://dipinkrishna.com/jsonlogin.php"];
//                
//                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//                
//                NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
//                
//                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//                [request setURL:url];
//                [request setHTTPMethod:@"POST"];
//                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//                [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//                [request setHTTPBody:postData];
//                
//                //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
//                
//                NSError *error = [[NSError alloc] init];
//                NSHTTPURLResponse *response = nil;
//                NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//                
//                NSLog(@"Response code: %ld", (long)[response statusCode]);
//                
//                if ([response statusCode] >= 200 && [response statusCode] < 300)
//                {
//                    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
//                    NSLog(@"Response ==> %@", responseData);
//                    
//                    NSError *error = nil;
//                    NSDictionary *jsonData = [NSJSONSerialization
//                        JSONObjectWithData:urlData
//                        options:NSJSONReadingMutableContainers
//                        error:&error];
//                    
//                    success = [jsonData[@"success"] integerValue];
//                    NSLog(@"Success: %ld",(long)success);
//                    
//                    if(success == 1)
//                    {
//                        NSLog(@"Login SUCCESS");
//                    } else {
//                        
//                        NSString *error_msg = (NSString *) jsonData[@"error_message"];
//                        [self alertStatus:error_msg :@"Sign in Failed!" :0];
//                    }
//                    
//                } else {
//                    //if (error) NSLog(@"Error: %@", error);
//                    [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
//                }
//            }
//        }
//        @catch (NSException * e) {
//            NSLog(@"Exception: %@", e);
//            [self alertStatus:@"Sign in Failed." :@"Error!" :0];
//        }
//        if (success) {
//            [self performSegueWithIdentifier:@"login_success" sender:self];
//        }
//    }
//    
//    - (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
//    {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
//    message:msg
//    delegate:self
//    cancelButtonTitle:@"Ok"
//    otherButtonTitles:nil, nil];
//    alertView.tag = tag;
//    [alertView show];
//    }
//
//        if username.text! == "Daniel" && password.text! == "password" {
//            // Create a new "Storyboard2" instance.
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            
//            // Create an instance of the storyboard's initial view controller.
//            let controller = storyboard.instantiateViewController(withIdentifier: "TabBarController") as UIViewController
//            
//            // Display the new view controller.
//            present(controller, animated: true, completion: nil)
//        }
    
        
    }
    
    @IBAction func backgroundTap(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
}
