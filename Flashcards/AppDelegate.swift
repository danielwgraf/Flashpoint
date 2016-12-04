//
//  AppDelegate.swift
//  Flashcards
//
//  Created by Daniel Graf on 10/27/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: Orientation
    
    
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        print("\n\n\n1\n\n\n")
        
        print(self.window?.rootViewController?.presentedViewController)
        if self.window?.rootViewController?.presentedViewController is ContainerViewController {
            print("\n\n\n1a\n\n\n")
            
            let containView = self.window!.rootViewController!.presentedViewController as! ContainerViewController
            
            let navController = containView.centerNavigationController
            if navController != nil {
                print("\n\n\n1aa\n\n\n")
                print(navController?.visibleViewController)
                if navController?.visibleViewController is ViewController {
                    print("\n\n\n1aaa\n\n\n")
                    let cardController = navController?.visibleViewController as! ViewController
            
                    if cardController.isPresented {
                        print("\n\n\n1aaaa\n\n\n")
                        return UIInterfaceOrientationMask.landscape;
                    } else {
                        print("\n\n\n1aaab\n\n\n")
                        return UIInterfaceOrientationMask.portrait;
                    }
                } else {
                    print("\n\n\n1aab\n\n\n")
                    return UIInterfaceOrientationMask.portrait;
                }
            } else {
                print("\n\n\n1ab\n\n\n")
                return UIInterfaceOrientationMask.portrait;
            }

        } else {
            print("\n\n\n1b\n\n\n")
            return UIInterfaceOrientationMask.portrait;
        }
        
    }

}

