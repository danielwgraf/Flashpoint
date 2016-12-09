//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//



import UIKit

@objc
protocol CenterViewControllerDelegate {
  @objc optional func toggleLeftPanel()
  @objc optional func toggleRightPanel()
  @objc optional func collapseSidePanels()
}



class CenterViewController: UIViewController, CardCenterViewControllerDelegate, SpecificDeckDelegate {
    

    
    var deckCardLabels: [String] = User.getDeckNames()
    var cardImages: [String] = ["DeckBack4.png"]
    var newDeck: Deck?
    var mainDeck: Deck?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        User.refresh()
        deckCardLabels = User.getDeckNames()
        self.collectionView.reloadData()
    }
    
    @IBAction func cancelToCenterViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveDeckDetail(segue:UIStoryboardSegue) {
        //add the new player to the players array
        User.refresh()
        deckCardLabels = User.getDeckNames()
        collectionView.reloadData()
        //may need to update tableview
    }
    
    var delegate: CenterViewControllerDelegate?
    
    
    //User.decks.names
    
  
    // MARK: Button actions
  
    @IBAction func menuTapped(_ sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
  
    @IBAction func refreshTapped(_ sender: AnyObject) {
        User.refresh()
        deckCardLabels = User.getDeckNames()
        self.collectionView.reloadData()
    }
    
    func setAsMainDeck() -> Deck? {
        if mainDeck != nil {
            return mainDeck
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DeckToCard" {
            let CardCenterVC = segue.destination as? CardCenterViewController
            
            CardCenterVC?.delegate = self
            CardCenterVC?.deckDelegate = self
            //CardCenterVC.deckNameLabel.text = "Deck"
        }
    }

}

extension CenterViewController: SidePanelViewControllerDelegate {
    @IBAction func DeckToCard(segue:UIStoryboardSegue) {
    }
    
    func segueToCards() {
        performSegue(withIdentifier: "DeckToCard", sender: nil)
    }
    
    func closePanels() {
        delegate?.collapseSidePanels!()
    }
}

extension CenterViewController: UICollectionViewDataSource, DeckCardCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return User.decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DeckCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCardCellIdentifier", for: indexPath) as! DeckCardCell
        cell.deckCardLabel.text = User.getDeckNames()[indexPath.row]
        cell.deckCardImage.image = UIImage(named: cardImages[0])
        let tapGestureRecognizer = UITapGestureRecognizer(target:cell, action:#selector(imageTapped(img:)))
        cell.deckCardImage.isUserInteractionEnabled = true
        cell.deckCardImage.addGestureRecognizer(tapGestureRecognizer)
        cell.delegate = self
        return cell
    }
    
    func imageTapped(img: AnyObject) {
        //So swift shuts up
    }
    
    func setMainDeckAndShift(deckName: String) {
        let newMainDeck = User.getDeckByName(deck_name: deckName)
        self.mainDeck = newMainDeck
        closePanels()
        segueToCards()
    }
    
    func toggleRightPanel() {
        delegate?.toggleRightPanel?()
    }
    
    func setMainDeck(deckName: String) {
        let newMainDeck = User.getDeckByName(deck_name: deckName)
        self.mainDeck = newMainDeck
    }
}
