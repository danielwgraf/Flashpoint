//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//



import UIKit

@objc
protocol CardCenterViewControllerDelegate {
  @objc optional func toggleLeftPanel()
  @objc optional func toggleRightPanel()
  @objc optional func collapseSidePanels()
}

protocol SpecificDeckDelegate {
    func deliverDeck(deck: Deck)
}

class CardCenterViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
    }
  
    var delegate: CardCenterViewControllerDelegate?
    var deckDelegate: SpecificDeckDelegate?
    
    
    //User.decks.names
    var cardLabels: [String] = ["Deck 1", "Deck 2", "Deck3", "Deck4", "Deck5", "Deck6"]
    var cardImages: [String] = ["back-1.png"]
    
  
    // MARK: Button actions
  
  
    @IBAction func studyBarTapped(_ sender: AnyObject) {
        delegate?.toggleRightPanel?()
    }
  
    
}

extension CardCenterViewController: SidePanelViewControllerDelegate {
    
}

extension CardCenterViewController: UICollectionViewDataSource, CardCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.deck.cards.count
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCellIdentifier", for: indexPath) as! CardCell
        cell.cardLabel.text = cardLabels[indexPath.row]
        cell.cardImage.image = UIImage(named: cardImages[0])
        cell.delegate = self
        return cell
    }
    
    func toggleRightPanel() {
        delegate?.toggleRightPanel?()
    }
}
