//
//  Flashcard.swift
//  Flashcards
//
//  Created by David S Gao on 9/26/16.
//  Copyright © 2016 David S Gao. All rights reserved.
//

import Foundation

struct Flashcard {
    
    let id: Int
    let deck_id: Int
    let word: String
    let definition: String
    
    init(id: Int, deck_id: Int, word: String, definition: String) {
        self.id = id
        self.deck_id = deck_id
        self.word = word
        self.definition = definition
    }
}
