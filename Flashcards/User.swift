//
//  User.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/7/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation

class User {
    
    static var id: Int = Int()
    static var email: String = String()
    static var facebook_id: Int = Int()
    static var decks: [Int] = []// Will store deck ids
    static var friends: [Int] = []// Will store user ids
    
    //static let sharedInstance = User()
    
    class func reset() {
        id = -1
        email = ""
        decks = []
        friends = []
    }
    
    class func getUserDecks() {
        print("UserID: \(id) FBID: \(facebook_id)")
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
    
    class func refresh() {
        User.getUserDecks()
    }
    
    func getUserFriends() {
        //var allUsers
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
        print("Deck Names: ",deckNames)
        return deckNames
    }
}
