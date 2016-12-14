//
//  DeckModelTests.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/14/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation
import XCTest
@testable import Flashcards

class DeckModelTests: XCTestCase {
    override func setUp() {
        User.reset()
        ServerAgent.sharedInstance.refresh()
        // Resetting for parsing
        ServerAgent.sharedInstance.cards = []
        ServerAgent.sharedInstance.decks = []
        User.id = 3
        User.facebook_id = 1020976866
        let deckData = loadJSONTestData(filename: "deckData")
        ServerAgent.sharedInstance.parseDecks(JSONData: deckData as! Data)
        let cardData = loadJSONTestData(filename: "cardData")
        ServerAgent.sharedInstance.parseCards(JSONData: cardData as! Data)
    }
    
    override func tearDown() {
        // Reset for later parsing
        ServerAgent.sharedInstance.cards = []
        ServerAgent.sharedInstance.decks = []
    }
    
    func testGetCardInfo() {
        var testDeck = User.getDeckById(id: 1)!
        testDeck.getDeckCards()
        let cardInfo = testDeck.getCardInfo()
        
        XCTAssertEqual(cardInfo.count, 2)
        XCTAssertEqual(cardInfo.first?.0, "TestCard")
        XCTAssertEqual(cardInfo.first?.1, "Test1")
        XCTAssertEqual(cardInfo.last?.0, "Test Word 2")
        XCTAssertEqual(cardInfo.last?.1, "Definition")
    }
    
    func loadJSONTestData(filename: String) -> NSData? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: filename, ofType: "json")
        return NSData(contentsOfFile: path!)
    }
}
