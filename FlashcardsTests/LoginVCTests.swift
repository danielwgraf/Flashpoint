//
//  LoginVCTests.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/13/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
@testable import Flashcards

class LoginVCTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testCheckIfUserExists() {
        let real_facebook_id = 1020976866
        let fake_facebook_id = 1234567890
        let loginViewController = LoginViewController()
        loginViewController.users = [(3,1020976866),(4,105981677)]
        loginViewController.facebook_id = real_facebook_id
        XCTAssertTrue(loginViewController.checkIfUserExists())
        
        loginViewController.facebook_id = fake_facebook_id
        XCTAssertFalse(loginViewController.checkIfUserExists())
    }
    
    func testNextAvailableId() {
        let loginViewController = LoginViewController()
        loginViewController.users = []
        XCTAssertEqual(3, loginViewController.nextAvailableId())
        
        loginViewController.users = [(3,1020976866),(4,105981677)]
        XCTAssertEqual(5, loginViewController.nextAvailableId())
    }
    
    func testCreateUser() {
        
    }
    
    
    func testGetUsers() {
        let urlString = "https://morning-castle-56124.herokuapp.com/users"
        let request = Alamofire.request(urlString)
        
        XCTAssertNotNil(request.request)
        XCTAssertEqual(request.request?.httpMethod, "GET")
        XCTAssertEqual(request.request?.url?.absoluteString, urlString)
        XCTAssertNil(request.response)
    }
    
    
    func testParseUsers() {
        let urlString = "https://morning-castle-56124.herokuapp.com/users"
        Alamofire.request(urlString).responseJSON { response in self.testParseUsersHelper(JSONData: response.data!) }
    }
    
    func testParseUsersHelper(JSONData: Data) {
        let loginViewController = LoginViewController()
        let results = loginViewController.parseUsers(JSONData: JSONData)
        
        XCTAssertNotNil(results)
    }
    
}
