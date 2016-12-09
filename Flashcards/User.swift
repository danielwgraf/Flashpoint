//
//  User.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/7/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation
import FacebookCore

class User {
    
    static var id: Int = Int()
    static var email: String = String()
    static var facebook_id: Int = Int()
    static var decks: [Int] = []// Will store deck ids
    static var sharedDecks: [Int] = [] //Stores decks shared with user
    static var fullDecks: [Int] = []
    static var friends: [Int] = []// Will store user ids
    
    
    class func reset() {
        id = -1
        email = ""
        decks = []
        sharedDecks = []
        fullDecks = []
        friends = []
    }
    
    class func getUserDecks() {
        decks = []
        ServerAgent.sharedInstance.refresh()
        let allDecks = ServerAgent.sharedInstance.decks
        for deck in allDecks {
            if deck.creator_id == User.id {
                if !decks.contains(deck.id) {
                    User.decks.append(deck.id)
                }
            }
        }
    }
    
    class func getSharedDecks() {
        sharedDecks = []
        ServerAgent.sharedInstance.refresh()
        let allDecks = ServerAgent.sharedInstance.decks
        for deck in allDecks {
            if deck.shared_ids.contains(User.id) {
                if !decks.contains(deck.id) {
                    if !sharedDecks.contains(deck.id) {
                        User.sharedDecks.append(deck.id)
                    }
                }
            }
        }
    }
    
    class func getFullDecks() {
        getUserDecks()
        getSharedDecks()
        fullDecks = decks+sharedDecks
    }
    
    
    class func refresh() {
        getFullDecks()
    }
    
    func getUserFriends() {
        
        

    }
    class func allDeckIDs() -> [Int] {
        var allIDs: [Int] = []
        let allDecks = ServerAgent.sharedInstance.decks
        for deck in allDecks {
            allIDs.append(deck.id)
        }
        return allIDs
    }
    
    class func getDeckNames() -> [String] {
        var deckNames: [String] = []
        User.getUserDecks()
        let allDecks = ServerAgent.sharedInstance.decks
        let allIDs = allDeckIDs()
        for deck in User.decks {
            let i = allIDs.index(of: deck)
            if i != nil {
                deckNames.append(allDecks[i!].deck_name)
            }
        }
        for deck in User.sharedDecks {
            let i = allIDs.index(of: deck)
            if i != nil {
                let editedName = allDecks[i!].deck_name+" (Shared)"
                deckNames.append(editedName)
            }
        }
        return deckNames
    }
    
    class func getDeckById(id: Int) -> Deck? {
        User.refresh()
        var allDecks = ServerAgent.sharedInstance.decks
        let allIDs = allDeckIDs()
        let i = allIDs.index(of: id)
        allDecks[i!].refresh()
        return allDecks[i!]
    }
    
    class func getDeckByName(deck_name: String) -> Deck? {
        User.refresh()
        let allNames = getDeckNames()
        let i = allNames.index(of: deck_name)
        return getDeckById(id: User.fullDecks[i!])
    }
}
