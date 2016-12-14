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
        ServerAgent.sharedInstance.refresh()
        User.id = 3
        User.facebook_id = 1020976866
        let data = loadJSONTestData(filename: "deckData")
        ServerAgent.sharedInstance.parseDecks(JSONData: data as! Data)
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
        XCTAssertEqual(User.decks.count, 0)
        
        User.getUserDecks()
        XCTAssertEqual(User.decks.count, 11)
    }
    
    func testGetSharedDecks() {
        XCTAssertEqual(User.sharedDecks.count, 0)
        
        // Need to get regular decks for the check to work
        User.getUserDecks()
        User.getSharedDecks()
        XCTAssertEqual(User.sharedDecks.count, 1)
    }
    
    func testGetFullDecks() {
        XCTAssertEqual(User.fullDecks.count, 0)
        
        User.getFullDecks()
        XCTAssertEqual(User.fullDecks.count, 12)
    }
    
    func testGetDeckNames() {
        User.getUserDecks()
        User.getSharedDecks()
        let deckNames = User.getDeckNames()
        
        XCTAssertEqual(deckNames.count, 12)
        XCTAssertEqual(deckNames.first, "New Test Deck")
        XCTAssertEqual(deckNames.last, "Deck 1 (Shared)")
    }
    
    func testGetDeckById() {
        var deck1 = Deck(id: 1, deck_name: "New Test Deck", creator_id: 3)
        deck1.shared_ids = [3]
        
        XCTAssertEqual(User.getDeckById(id: 1)!.id, deck1.id)
        XCTAssertEqual(User.getDeckById(id: 1)!.deck_name, deck1.deck_name)
        XCTAssertEqual(User.getDeckById(id: 1)!.creator_id, deck1.creator_id)
        XCTAssertEqual(User.getDeckById(id: 1)!.shared_ids, deck1.shared_ids)
        
        // Non-Existent Deck
        XCTAssertNil(User.getDeckById(id: 100))
    }
    
    func testGetDeckByName() {
        var deck1 = Deck(id: 1, deck_name: "New Test Deck", creator_id: 3)
        deck1.shared_ids = [3]
        
        XCTAssertEqual(User.getDeckByName(deck_name: "New Test Deck")!.id, deck1.id)
        XCTAssertEqual(User.getDeckByName(deck_name: "New Test Deck")!.deck_name, deck1.deck_name)
        XCTAssertEqual(User.getDeckByName(deck_name: "New Test Deck")!.creator_id, deck1.creator_id)
        XCTAssertEqual(User.getDeckByName(deck_name: "New Test Deck")!.shared_ids, deck1.shared_ids)
        
        // Non-Existent Deck
        XCTAssertNil(User.getDeckByName(deck_name: "Non-Existent Deck"))
    }
    
    func loadJSONTestData(filename: String) -> NSData? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: filename, ofType: "json")
        return NSData(contentsOfFile: path!)
    }
}
