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
        let serverAgent = ServerAgent.sharedInstance
        let allDecks = serverAgent.decks
        for deck in allDecks {
            if deck.creator_id == User.id {
                User.decks.append(deck.id)
            }
        }
    }
    
    func getUserFriends() {
        //var allUsers
    }
}
