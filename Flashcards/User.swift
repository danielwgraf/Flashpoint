//
//  User.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/7/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation

struct User {
    
    let id: Int
    let decks: [Deck]
    let friends: [User]
    
    static let sharedInstance = User()
    
    init(id: Int) {
        self.id = id
        self.decks = []
        self.friends = []
    }
}
