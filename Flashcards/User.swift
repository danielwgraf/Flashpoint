//
//  User.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/7/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation
import FacebookCore

/// Creates the User class which is implemented as a class, because only one user should be logged in. So there are a bunch of static variables and class variables
class User {
    
    /// User ID
    static var id: Int = Int()
    /// Email (from Facebook)
    static var email: String = String()
    /// Facebook ID (from Facebook)
    static var facebook_id: Int = Int()
    /// A list of deck IDs that belong to the User
    static var decks: [Int] = []// Will store deck ids
    /// A list of the deck IDs where the user is in their shared list
    static var sharedDecks: [Int] = [] //Stores decks shared with user
    /// A combined list of personal and shared decks
    static var fullDecks: [Int] = []
    /// A list of friend ID's for when sharing is better implemented
    static var friends: [Int] = []// Will store user ids
    
    /// Reset function that should be used on logout.
    class func reset() {
        id = -1
        email = ""
        decks = []
        sharedDecks = []
        fullDecks = []
        friends = []
    }
    
    /// Loads the User's decks
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
    
    /// Loads the User's shared decks
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
    
    /// The real function that will be called. Calls both of the "getDecks" functions and then appends them together
    class func getFullDecks() {
        getUserDecks()
        getSharedDecks()
        fullDecks = decks+sharedDecks
    }
    
    /// Refresh function. Used for clarity's sake
    class func refresh() {
        getFullDecks()
    }
    
    /// For future implementation. Will get friends from Facebook and store their IDs
    func getUserFriends() {
        
    }
    
    /**
     Takes the list of all of the decks (from the serveragent) and returns them as a list of IDs
     
     - Returns: A list of Int IDs
 
    */
    class func allDeckIDs() -> [Int] {
        var allIDs: [Int] = []
        let allDecks = ServerAgent.sharedInstance.decks
        for deck in allDecks {
            allIDs.append(deck.id)
        }
        return allIDs
    }
    
    
    /**
     Takes the list of all of the decks (from the serveragent) and returns the list of names in the user's decks
     
     - Returns: A list of String names
     
     */
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
    
    /**
     A simple function which finds a Deck based on an ID
     
     - Parameter id: The ID of the desired deck
     
     - Returns: The deck if it exists. Otherwise nil.
 
     */
    class func getDeckById(id: Int) -> Deck? {
        User.refresh()
        var allDecks = ServerAgent.sharedInstance.decks
        let allIDs = allDeckIDs()
        let i = allIDs.index(of: id)
        allDecks[i!].refresh()
        return allDecks[i!]
    }
    
    /**
     A simple function which finds a Deck based on a name
     
     - Parameter deck_name: The name of the desired deck
     
     - Returns: The deck if it exists. Otherwise nil.
     
     */
    class func getDeckByName(deck_name: String) -> Deck? {
        User.refresh()
        let allNames = getDeckNames()
        let i = allNames.index(of: deck_name)
        return getDeckById(id: User.fullDecks[i!])
    }
}
