//
//  ServerAgentTest.swift
//  Flashcards
//
//  Created by Christine Wu on 12/13/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import XCTest
import SwiftyJSON
import Alamofire
@testable import Flashcards


class ServerAgentTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        testGetCards()
        testParseCards()
        testGetDecks()
        testParseDecks()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetCards() {
        let urlString = "https://morning-castle-56124.herokuapp.com/cards"
        let request = Alamofire.request(urlString)
        
        XCTAssertNotNil(request.request)
        XCTAssertEqual(request.request?.httpMethod, "GET")
        XCTAssertEqual(request.request?.url?.absoluteString, urlString)
        XCTAssertNil(request.response)
    }
    
    func testParseCards() {
        let urlString = "https://morning-castle-56124.herokuapp.com/cards"
        Alamofire.request(urlString).responseJSON { response in self.testParseCardsHelper(JSONData: response.data!) }
    }
    
    func testParseCardsHelper(JSONData: Data) {
        let serverAgent = ServerAgent()
        let results = serverAgent.parseCards(JSONData: JSONData)
        
        XCTAssertNotNil(results)
    }
    
    func testGetDecks() {
        let urlString = "https://morning-castle-56124.herokuapp.com/decks"
        let request = Alamofire.request(urlString)
        
        XCTAssertNotNil(request.request)
        XCTAssertEqual(request.request?.httpMethod, "GET")
        XCTAssertEqual(request.request?.url?.absoluteString, urlString)
        XCTAssertNil(request.response)
        
    }
    
    func testParseDecks() {
        let urlString = "https://morning-castle-56124.herokuapp.com/decks"
        Alamofire.request(urlString).responseJSON { response in self.testParseDecksHelper(JSONData: response.data!) }
        
    }
    
    func testParseDecksHelper(JSONData: Data) {
        let serverAgent = ServerAgent()
        let results = serverAgent.parseDecks(JSONData: JSONData)
        
        XCTAssertNotNil(results)
    }
    
}
