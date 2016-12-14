//
//  UserModelTests.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/13/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation
import XCTest
@testable import Flashcards

class UserModelTests: XCTestCase {
    override func setUp() {
        User.reset()
        User.id = 42
        User.facebook_id = 1234
        User.decks = []
        //User.
    }

    func testReset() {
        User.reset()
        XCTAssertEqual(User.id, -1)
        XCTAssertEqual(User.facebook_id, -1)
        XCTAssertEqual(User.decks, [])
        XCTAssertEqual(User.sharedDecks, [])
        XCTAssertEqual(User.fullDecks, [])
    }

    func testGetUserDecks() {
        User.id = 3
        XCTAssertEqual(User.decks.count, 0)
        
        User.getUserDecks()
        sleep(5)
        XCTAssertEqual(User.decks.count, 11)
    }
    
    func testGetSharedDecks() {
        User.id = 3
        XCTAssertEqual(User.sharedDecks.count, 0)
        
        User.getSharedDecks()
        sleep(5)
        XCTAssertEqual(User.sharedDecks.count, 1)
    }
    
    func testGetFullDecks() {
        User.id = 3
        XCTAssertEqual(User.fullDecks.count, 0)
        
        User.getFullDecks()
        sleep(5)
        XCTAssertEqual(User.decks.count, 12)
    }
//
//    class func getDeckNames() -> [String]
//    
//    class func getDeckById(id: Int) -> Deck?
//    
//    class func getDeckByName(deck_name: String) -> Deck?
}
