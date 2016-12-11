//
//  Flashcard.swift
//  Flashcards
//
//  Created by David S Gao on 9/26/16.
//  Copyright © 2016 David S Gao. All rights reserved.
//

import Foundation
///Flashcard object. Pretty straigtforward
struct Flashcard {
    /// Card ID
    let id: Int
    /// ID of the deck holding the card
    let deck_id: Int
    /// Card's word (set by user)
    let word: String
    /// Card's definition (set by user)
    let definition: String
    
    /**
     Deck Initialization function
     
     - Parameters:
        - id: The Deck ID.
        - deck_id: The id of the deck holding the card
        - word: Word on the card
        - definition: Definition on the card
     */
    init(id: Int, deck_id: Int, word: String, definition: String) {
        self.id = id
        self.deck_id = deck_id
        self.word = word
        self.definition = definition
    }
}
