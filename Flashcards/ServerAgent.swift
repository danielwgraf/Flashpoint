//
//  ServerAgent.swift
//  Flashcards
//
//  Created by Christine Wu on 12/6/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

///Class that handles all of the network calls
class ServerAgent {
    /// List of Cards
    var cards = [Flashcard]()
    /// List of decks
    var decks = [Deck]()

    init() {
        self.getCards()
        self.getDecks()
    }
    
    func refresh() {
        self.getCards()
        self.getDecks()
    }
    
    static let sharedInstance = ServerAgent()

    //MARK: Cards
    
    func getCards() {
        Alamofire.request("https://morning-castle-56124.herokuapp.com/cards").responseJSON {
            response in
            self.parseCards(JSONData: response.data!)
        }
    }
    
    func parseCards(JSONData: Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! NSArray
            for i in 0..<readableJSON.count {
                var card = JSON(readableJSON[i])
                let id = card["id"].int
                let word = card["word"].string
                let definition = card["definition"].string
                let deck_id = card["deck_id"].int
                //print(id,word,definition,deck_id)
                if (id != nil)&&(deck_id != nil)&&(word != nil)&&(definition != nil) {
                    let cardObj = Flashcard(id: id!, deck_id: deck_id!, word: word!, definition: definition!)
                    cards.append(cardObj)
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    //MARK: Decks
    
    func getDecks() {
        Alamofire.request("https://morning-castle-56124.herokuapp.com/decks").responseJSON {
            response in
            self.parseDecks(JSONData: response.data!)
        }
    }
    
    func parseDecks(JSONData: Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! NSArray
            for i in 0..<readableJSON.count {
                var deck = JSON(readableJSON[i])
                let id = deck["id"].int
                let deck_name = deck["deck_name"].string
                let shared_ids = deck["shared_ids"].arrayObject
                let user_id = deck["user_id"].int
                
                if (id != nil)&&(deck_name != nil)&&(user_id != nil) {
                    var deckObj = Deck(id: id!, deck_name: deck_name!, creator_id: user_id!)
                    if shared_ids != nil {
                        deckObj.shared_ids = (shared_ids as? [Int])!
                    }
                    decks.append(deckObj)
                }
            }
        }
        catch {
            print(error)
        }
    }
}
