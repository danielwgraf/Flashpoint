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


/// The VC which contains all of the decks. Showed right after the log-in scene
class CenterViewController: UIViewController, CardCenterViewControllerDelegate, SpecificDeckDelegate {
    
    /// A list of all of the deck names
    var deckCardLabels: [String] = User.getDeckNames()
    /// The different images of the decks (either normal or shared)
    var cardImages: [String] = ["DeckBack4.png","SharedBackground.png"]
    /// Used after creating a deck
    var newDeck: Deck?
    /// Variable which tells the different VCs which deck to show
    var mainDeck: Deck?
    /// Yellow color of the text.
    var yellow = UIColor(red: 1, green: 1, blue: 19/255, alpha: 1)
    /// Collection of all the decks
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
    
    /// Segue to cancel adding a deck
    @IBAction func cancelToCenterViewController(segue:UIStoryboardSegue) {
    }
    
    /// Segue to adding a deck. Refreshes so after being added it shows on the view
    @IBAction func saveDeckDetail(segue:UIStoryboardSegue) {
        //add the new player to the players array
        User.refresh()
        deckCardLabels = User.getDeckNames()
        collectionView.reloadData()
        //may need to update tableview
    }
    
    /// Connects to the Container view, which then connects to the sideviews
    var delegate: CenterViewControllerDelegate?
    
  
    // MARK: Button actions
  
    /// Opens the left panel to access Logout. Eventually decks and friends section
    @IBAction func menuTapped(_ sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
  
    /// Refreshes the deck. Just a safety precaution for when the world which is the API is annoying
    @IBAction func refreshTapped(_ sender: AnyObject) {
        User.refresh()
        deckCardLabels = User.getDeckNames()
        self.collectionView.reloadData()
    }
    
    /** 
     Sets the main deck variable to the variable you want
     
     - Retuns: The main deck, if it exists
 
     */
    func setAsMainDeck() -> Deck? {
        if mainDeck != nil {
            return mainDeck
        }
        return nil
    }
    
    //Checks if the segue is moving to the card view screen so then the main deck can be moved to that screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DeckToCard" {
            let CardCenterVC = segue.destination as? CardCenterViewController
            
            CardCenterVC?.delegate = self
            CardCenterVC?.deckDelegate = self
            //CardCenterVC.deckNameLabel.text = "Deck"
        }
    }

}

// An extension to have a relationship between the center and side view
extension CenterViewController: SidePanelViewControllerDelegate {
    /// Segue between decks and cards
    @IBAction func DeckToCard(segue:UIStoryboardSegue) {
    }
    
    /// Call function to segue with buttons (the view/eye button)
    func segueToCards() {
        performSegue(withIdentifier: "DeckToCard", sender: nil)
    }
    
    /// When view button is clicked, buttons are closed
    func closePanels() {
        delegate?.collapseSidePanels!()
    }
}

// Extensions helping with the collection views and then the decks within
extension CenterViewController: UICollectionViewDataSource, DeckCardCellDelegate {
    
    // Count is based on the User's deck size
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return User.decks.count + User.sharedDecks.count
    }
    
    // Creates the decks in the main view, handles deck types, and tapping on decks
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Creation
        let cell: DeckCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCardCellIdentifier", for: indexPath) as! DeckCardCell
        cell.deckCardLabel.text = User.getDeckNames()[indexPath.row]
        let cardID = (User.getDeckByName(deck_name: (User.getDeckNames()[indexPath.row]))?.id)!
        
        // Changes based on type
        if User.sharedDecks.contains(cardID) && !User.decks.contains(cardID){
            cell.deckCardImage.image = UIImage(named: cardImages[1])
            cell.deckCardLabel.textColor = UIColor.black
        } else {
            cell.deckCardImage.image = UIImage(named: cardImages[0])
            cell.deckCardLabel.textColor = yellow
        }
        
        // Handles tap recognizor for decks
        let tapGestureRecognizer = UITapGestureRecognizer(target:cell, action:#selector(imageTapped(img:)))
        cell.deckCardImage.isUserInteractionEnabled = true
        cell.deckCardImage.addGestureRecognizer(tapGestureRecognizer)
        cell.delegate = self
        return cell
    }
    
    /// No Purpose other than shutting up swift. The function is really in the cell
    func imageTapped(img: AnyObject) {
        //So swift shuts up
    }
    
    /**
     The function used to view the deck
    - Parameter deckName: Finds by deckName because it's all that the cell stores
    */
    func setMainDeckAndShift(deckName: String) {
        let newMainDeck = User.getDeckByName(deck_name: deckName)
        self.mainDeck = newMainDeck
        closePanels()
        segueToCards()
    }
    
    /// Opens the right panel because of the options button. Comes from deck options button and sends to container view
    func toggleRightPanel() {
        delegate?.toggleRightPanel?()
    }
    
    /** 
     Sets main deck again. (because it needs to be able to be set in multiple places to ensure the transfer)
     - Parameter deckName: Finds by deckName because it's all that the cell stores
    */
    func setMainDeck(deckName: String) {
        let newMainDeck = User.getDeckByName(deck_name: deckName)
        self.mainDeck = newMainDeck
    }
}
