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

class ServerAgent {

    init() {
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
                let id = card["id"]
                let word = card["word"]
                let definition = card["definition"]
                let deck_id = card["deck_id"]
                print(id,word,definition,deck_id)
                //let cardObj = Flashcard(id: id,deck_id: deck_id,word: word,definition: definition)

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
                let id = deck["id"]
                let deck_name = deck["deck_name"]
                let shared_ids = deck["shared_ids"]
                let user_id = deck["user_id"]
                print(id,deck_name,shared_ids,user_id)
//                let deckObj = Deck()
//                deckObj.id = id
//                deckObj.deck_name = deck_name
//                deckObj.shared_ids = shared_ids
//                deckObj.user_id = user_id
            }
        }
        catch {
            print(error)
        }
    }
}
