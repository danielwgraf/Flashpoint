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
    var cards: [Flashcard]
    let creator_id: Int
    var shared_ids: [Int]
    
    func drawRandomCard() -> Flashcard? {
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
    
    mutating func getDeckCards() {
        let allCards = ServerAgent.sharedInstance.cards
        for card in allCards {
            if card.deck_id == self.id {
                self.cards.append(card)
            }
        }
    }
    
    
}
