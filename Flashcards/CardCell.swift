//
//  CardCell.swift
//  Flashcards
//
//  Created by Daniel Graf on 12/8/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import UIKit

@objc
protocol CardCellDelegate {
    @objc optional func toggleRightPanel()
}

class CardCell: UICollectionViewCell {
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBAction func cardButton(_ sender: AnyObject) {
        delegate?.toggleRightPanel?()
    }
    
    @IBOutlet weak var cardLabel: UILabel!
    
    var delegate: CardCellDelegate?
}
