//
//  CardCell.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/8/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//
// Sets up all of the cards seen by the users (very similar to DeckCardCell)

import UIKit

@objc
protocol CardCellDelegate {
    @objc optional func toggleRightPanel()
}

/// The class for Card Objects that are showed to users
class CardCell: UICollectionViewCell {
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    
    /**
     The options button on a crd which will open the sidebar
     
     - Parameter sender: The button that was clicked
     */
    @IBAction func cardButton(_ sender: AnyObject) {
        delegate?.toggleRightPanel?()
    }
    
    ///This delegate is used to send info to the sidebar
    var delegate: CardCellDelegate?
}
