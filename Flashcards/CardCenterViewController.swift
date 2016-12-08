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
    func setMainDeck()
}


class CardCenterViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deckNameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
    }
  
    var delegate: CardCenterViewControllerDelegate?
    var deckDelegate: SpecificDeckDelegate? = nil
    
    var mainDeck: Deck?
    
    
    //User.decks.names
    var cardLabels: [String] = ["Deck 1", "Deck 2", "Deck3", "Deck4", "Deck5", "Deck6"]
    var cardImages: [String] = ["back-1.png"]
    
    
    @IBAction func cancelToCardCenterViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveCardDetail(segue:UIStoryboardSegue) {
        //add the new player to the players array
        User.refresh()
        //deckCardLabels = User.getDeckNames()
        collectionView.reloadData()
        //may need to update tableview
    }
    
  
    // MARK: Button actions
  
    @IBAction func test (_ sender: AnyObject) {
        deckDelegate!.setMainDeck()
    }
  
    @IBAction func studyBarTapped(_ sender: AnyObject) {
        delegate?.toggleRightPanel?()
    }
  
    
}



extension CardCenterViewController: UICollectionViewDataSource, CardCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.deck.cards.count
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCellIdentifier", for: indexPath) as! CardCell
        cell.cardLabel.text = mainDeck?.getCardInfo()[indexPath.row].0
        cell.cardImage.image = UIImage(named: cardImages[0])
        cell.delegate = self
        return cell
    }
    
    func toggleRightPanel() {
        delegate?.toggleRightPanel?()
    }
}
