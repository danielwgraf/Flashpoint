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
    func setAsMainDeck()->Deck?
}


/// The view when a deck is clicked on. Shows all the decks
class CardCenterViewController: UIViewController {
    /// View holding all of the decks
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// Name of the deck/shown on top
    @IBOutlet weak var deckViewLabel: UILabel!
    
    /// Refreshes the view (from refresh button)
    @IBAction func refresh(_ sender: Any) {
        User.refresh()
        self.collectionView.reloadData()
    }
    
    /// Loads the view
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        mainDeck = (deckDelegate?.setAsMainDeck())!
        deckViewLabel.text = mainDeck?.deck_name
        mainDeck?.refresh()
    }
    
    /// Reloads when the view appears (precautionary)
    override func viewDidAppear(_ animated: Bool) {
        mainDeck = (deckDelegate?.setAsMainDeck())!
        deckViewLabel.text = mainDeck?.deck_name
        mainDeck?.refresh()
        collectionView.reloadData()
    }
  
    // Delegates that both come the deck center
    var delegate: CardCenterViewControllerDelegate?
    var deckDelegate: SpecificDeckDelegate? = nil
    
    /// The deck which the cards come from
    var mainDeck: Deck?
    
    /// The one back image. Can be updated with more
    var cardImages: [String] = ["back-1.png"]
    
    /// Segue to cancel card creation
    @IBAction func cancelToCardCenterViewController(segue:UIStoryboardSegue) {
    }
    
    /// Segue to save the card
    @IBAction func saveCardDetail(segue:UIStoryboardSegue) {
        //add the new player to the players array
        User.refresh()
        mainDeck?.refresh()
        //deckCardLabels = User.getDeckNames()
        collectionView.reloadData()
        //may need to update tableview
    }
    
  
    // MARK: Button actions
    /// Does absolutely nothing
    @IBAction func test (_ sender: AnyObject) {
        //deckDelegate!.setAsMainDeck()
    }
  
    /// Actually doesn't do anything but place hold
    @IBAction func studyBarTapped(_ sender: AnyObject) {
        delegate?.toggleRightPanel?()
    }
    
    // Prepares for the two segues (adding and studying
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCard" {
            let navController = segue.destination as? UINavigationController
            if navController != nil {
                if navController?.visibleViewController is CardDetailsViewController {
                    let AddCard = navController?.visibleViewController as! CardDetailsViewController
                    AddCard.deck_id = mainDeck?.id
                }
            }
        } else if segue.identifier == "StudySegue" {
            let viewController = segue.destination as? ViewController
            viewController?.deck = self.mainDeck
        }
    }
}



extension CardCenterViewController: UICollectionViewDataSource, CardCellDelegate {
    // Count comes from deck size
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainDeck!.cards.count
    }
    
    // Creates all of the cards
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCellIdentifier", for: indexPath) as! CardCell
        cell.cardLabel.text = mainDeck?.getCardInfo()[indexPath.row].0
        cell.cardImage.image = UIImage(named: cardImages[0])
        cell.delegate = self
        return cell
    }
    
    /// Opens the right panel
    func toggleRightPanel() {
        delegate?.toggleRightPanel?()
    }
}
