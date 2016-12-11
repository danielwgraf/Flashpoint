//
//  GameRoom.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/7/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation

/// Struct that could be further used to game-ify the study process. Wasn't implemented due to time constraints, but it exists in the server as well
struct GameRoom {
    
    let id: Int
    let deck_id: Int
    let asker_id: Int
    let teller_id: Int
    
    init(id: Int, deck_id: Int, asker_id: Int, teller_id: Int) {
        self.id = id
        self.deck_id = deck_id
        self.asker_id = asker_id
        self.teller_id = teller_id
    }
}
