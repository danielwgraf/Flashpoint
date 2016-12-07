//
//  DeckListViewModel.swift
//  Flashcards
//
//  Created by Daniel Graf on 11/17/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import Foundation

class DeckListViewModel {
    var decks = [Deck]()
    var filteredDecks = [Deck]()
    
    //var deck = Deck()
    
//    let client = SearchRepositoriesClient()
//    let parser = RepositoriesParser()

    func refresh() {
//    func refresh(completion: @escaping () -> Void) {
//        client.fetchRepositories { [unowned self] data in
//            if let repositories = self.parser.repositoriesFromSearchResponse(data) {
//                self.repos = repositories
//            }
//            completion()
//        }
        
        //decks.append(deck)
    }
    
    func numberOfRows() -> Int {
        if filteredDecks.isEmpty {
            return decks.count
        } else {
            return filteredDecks.count
        }
    }
    
    func titleForRowAtIndexPath(indexPath: NSIndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < decks.count else {
            return ""
        }
        
        if filteredDecks.isEmpty {
            return decks[indexPath.row].deck_name
        } else {
            return filteredDecks[indexPath.row].deck_name
        }
    }
    
//    func summaryForRowAtIndexPath(indexPath: NSIndexPath) -> String {
//        guard indexPath.row >= 0 && indexPath.row < decks.count else {
//            return ""
//        }
//        if filteredDecks.isEmpty {
//            return decks[indexPath.row].description
//        } else {
//            return filteredDecks[indexPath.row].description
//        }
//    }
    

//    func detailViewModelForRowAtIndexPath(indexPath: NSIndexPath) -> RepositoryDetailViewModel {
//        let repo = (filteredRepos.isEmpty ? repos[indexPath.row] : filteredRepos[indexPath.row])
//        return RepositoryDetailViewModel(repository: repo)
//    }
    
    func updateFiltering(searchText: String) -> Void {
        filteredDecks = self.decks.filter { deck in
            return deck.deck_name.lowercased().contains(searchText.lowercased())
        }
    }
    
}
