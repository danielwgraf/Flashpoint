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
    let serverAgent = ServerAgent()
    
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
        let results = serverAgent.parseCards(JSONData: JSONData)
        
        XCTAssertNotNil(results)
    }
    
    func testParseCardsWithData() {
        let data = loadJSONTestData(filename: "cardData")
        print("\n\n\n\ndata = \(data)")
        serverAgent.parseCards(JSONData: data as! Data)
        sleep(5)
        let results = serverAgent.cards
        
        XCTAssertEqual(28, results.count)
        
        let first = results.first
        
        XCTAssertEqual(1, first?.id)
        XCTAssertEqual("Test", first?.word)
        XCTAssertEqual("Test2", first?.definition)
        XCTAssertEqual(5, first?.deck_id)
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
        let results = serverAgent.parseDecks(JSONData: JSONData)
        
        XCTAssertNotNil(results)
    }
    
    func testParseDecksWithData() {
        let data = loadJSONTestData(filename: "deckData")
        serverAgent.parseDecks(JSONData: data as! Data)
        let results = serverAgent.decks
        
        XCTAssertEqual(19, results.count)
        
        let first = results.first!
        XCTAssertEqual(1, first.id)
        XCTAssertEqual("New Test Deck", first.deck_name)
        XCTAssertEqual(3, first.creator_id)
        XCTAssertEqual([3], first.shared_ids)
    }
    
    func loadJSONTestData(filename: String) -> NSData? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: filename, ofType: "json")
        return NSData(contentsOfFile: path!)
//        let bundle = Bundle(for: type(of: self))
//        if let path = bundle.path(forResource: filename, ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//                let jsonObj = JSON(data: data)
//                if jsonObj != JSON.null {
//                    print("jsonData:\(jsonObj)")
//                } else {
//                    print("Could not get json from file, make sure that file contains valid json.")
//                }
//            } catch let error {
//                print("Error with JSON:",error.localizedDescription)
//            }
//        } else {
//            print("Invalid filename/path.")
//        }
//        return Data(base64Encoded: "")
    }
    
}
