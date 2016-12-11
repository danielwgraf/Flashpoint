//
//  Deck.swift
//  Flashcards
//
//  Created by David S Gao on 9/26/16.
//  Copyright © 2016 David S Gao. All rights reserved.
//
// All things involving the Deck Object, based on the structure created online in our API
//

import Foundation
///  The Deck Struct which is used by parsing data from our API and creating objects for all of the users decks based on their IDs
struct Deck {
    /// The Deck ID
    let id: Int
    /// The Deck name created by the user
    var deck_name: String
    /// A list of card IDs contained within the deck
    var cards: [Int]
    /// The ID of the user who made the deck
    let creator_id: Int
    /// A list of User IDs who are able to see the deck because it was shared with them
    var shared_ids: [Int]
    
    /**
    A function used for shuffling decks when studying; not effectively implemented yet
     
    - Returns: Int?
    */
    func drawRandomCard() -> Int? {
        if cards.isEmpty {  // shouldn't ever really be an issue; just being safe...
            return nil
        } else {
            // return a flashcard object from the deck cards
            return cards[Int(arc4random_uniform(UInt32(cards.count)))]
        }
    }
    
    /**
     Deck Initialization function
     
     - Parameters: 
        - id: The Deck ID.
        - deck_name: The Deck Name.
        - creator_id: The ID of the user that created the deck.
     */
    init(id: Int, deck_name: String, creator_id: Int) {
        self.id = id
        self.deck_name = deck_name
        self.creator_id = creator_id
        self.cards = []
        self.shared_ids = []
    }
    
    /// Refresh function; just used for clarity, and ensures that the shown decks are up to date after being created
    mutating func refresh() {
        getDeckCards()
    }
    
    /// Gets the cards in the deck from the server and makes sure the data is accurate
    mutating func getDeckCards() {
        let allCards = ServerAgent.sharedInstance.cards
        for card in allCards {
            if card.deck_id == self.id {
                if !self.cards.contains(card.id) {
                    self.cards.append(card.id)
                }
            }
        }
    }
    
    /// Function that gets a list of all card IDs from the database (very ineffictient, but works on a small scale)
    func allCardIDs() -> [Int] {
        var allIDs: [Int] = []
        let allCards = ServerAgent.sharedInstance.cards
        for card in allCards {
            allIDs.append(card.id)
        }
        return allIDs
    }
    
    /**
     Gets a list of all the card words and definitions and returns them as a list of tuples
     
     - Returns: [(word, definition)]
     */
    mutating func getCardInfo() -> [(String,String)] {
        var cardInfo: [(String,String)] = []
        User.refresh()
        self.refresh()
        let allCards = ServerAgent.sharedInstance.cards
        let allIDs = allCardIDs()
        for card in self.cards {
            let i = allIDs.index(of: card)
            if i != nil {
                cardInfo.append((allCards[i!].word,allCards[i!].definition))
            }
        }
        return cardInfo
    }
    
    
}
