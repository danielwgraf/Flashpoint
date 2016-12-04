//
//  Flashcard.swift
//  Flashcards
//
//  Created by David S Gao on 9/26/16.
//  Copyright © 2016 David S Gao. All rights reserved.
//

import Foundation

struct Flashcard {
    
    let command: String
    let definition: String
    
    init(command: String, definition: String) {
        self.command = command
        self.definition = definition
    }
}