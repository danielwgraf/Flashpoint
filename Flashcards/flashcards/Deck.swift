//
//  Deck.swift
//  Flashcards
//
//  Created by David S Gao on 9/26/16.
//  Copyright © 2016 David S Gao. All rights reserved.
//

import Foundation

struct Deck {
    
    let id: Int
    var deck_name: String
    var cards: [Int]
    let creator_id: Int
    var shared_ids: [Int]
    
    func drawRandomCard() -> Int? {
        if cards.isEmpty {  // shouldn't ever really be an issue; just being safe...
            return nil
        } else {
            // return a flashcard object from the deck cards
            return cards[Int(arc4random_uniform(UInt32(cards.count)))]
        }
    }
    
    init(id: Int, deck_name: String, creator_id: Int) {
        self.id = id
        self.deck_name = deck_name
        self.creator_id = creator_id
        self.cards = []
        self.shared_ids = []
    }
    
    mutating func refresh() {
        getDeckCards()
    }
    
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
    
    func allCardIDs() -> [Int] {
        var allIDs: [Int] = []
        let allCards = ServerAgent.sharedInstance.cards
        for card in allCards {
            allIDs.append(card.id)
        }
        return allIDs
    }
    
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
