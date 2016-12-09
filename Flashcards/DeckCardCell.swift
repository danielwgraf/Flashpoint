//
//  CardCell.swift
//  
//
//  Created by Christine Wu on 12/7/16.
//
//

import UIKit

@objc
protocol DeckCardCellDelegate {
    @objc optional func toggleRightPanel()
    @objc optional func setMainDeck(deckName: String)
    @objc optional func setMainDeckAndShift(deckName: String)
}

class DeckCardCell: UICollectionViewCell {
    
    @IBOutlet weak var deckCardImage: UIImageView!
    
    
    @IBAction func deckCardButton(_ sender: Any) {
        delegate?.toggleRightPanel?()
        delegate?.setMainDeck!(deckName: deckCardLabel.text!)
    }
    
    func imageTapped(img: AnyObject){
        delegate?.setMainDeckAndShift!(deckName: deckCardLabel.text!)
    }
    
    @IBOutlet weak var deckCardLabel: UILabel!
    
    var delegate: DeckCardCellDelegate?

    

}

