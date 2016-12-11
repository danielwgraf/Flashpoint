//
//  DeckCardCell.swift
//  
//
//  Sets up all of the decks seen by the users
//

import UIKit

@objc
protocol DeckCardCellDelegate {
    @objc optional func toggleRightPanel()
    @objc optional func setMainDeck(deckName: String)
    @objc optional func setMainDeckAndShift(deckName: String)
}

/// The class for Deck Objects that are showed to users
class DeckCardCell: UICollectionViewCell {
    
    @IBOutlet weak var deckCardImage: UIImageView!
    @IBOutlet weak var deckCardLabel: UILabel!
    
    /**
     The options button on a deck which will open the sidebar
     
     - Parameter sender: The button that was clicked
     */
    @IBAction func deckCardButton(_ sender: Any) {
        delegate?.toggleRightPanel?()
        delegate?.setMainDeck!(deckName: deckCardLabel.text!)
    }
    
    /**
     If the deck image was clicked on, it will go straight to opening the deck
     
     - Parameter img: The img that was clicked
     */
    func imageTapped(img: AnyObject){
        delegate?.setMainDeckAndShift!(deckName: deckCardLabel.text!)
    }
    
    ///This delegate is used to send info to the sidebar, to the main section, and then the cards. Very complicated
    var delegate: DeckCardCellDelegate?

    

}

