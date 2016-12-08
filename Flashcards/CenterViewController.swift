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

class CenterViewController: UIViewController {
    
    var cardLabels: [String] = ["Deck 1", "Deck 2", "Deck3", "Deck4", "Deck5", "Deck6"]
    var cardImages: [String] = ["back-1.png"]
    var newDeck: Deck?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    @IBAction func cancelToCenterViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveDeckDetail(segue:UIStoryboardSegue) {
        //add the new player to the players array
        cardLabels.append((newDeck?.deck_name)!)
        //may need to update tableview
    }
    
  var delegate: CenterViewControllerDelegate?
    
    //User.decks.names
    
  
  // MARK: Button actions
  
  @IBAction func menuTapped(_ sender: AnyObject) {
    delegate?.toggleLeftPanel?()
  }
  
  @IBAction func refreshTapped(_ sender: AnyObject) {
    self.collectionView.reloadData()
  }

}

extension CenterViewController: SidePanelViewControllerDelegate {
    
}

extension CenterViewController: UICollectionViewDataSource, DeckCardCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return User.decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DeckCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCardCellIdentifier", for: indexPath) as! DeckCardCell
        cell.deckCardLabel.text = cardLabels[indexPath.row]
        cell.deckCardImage.image = UIImage(named: cardImages[0])
        cell.delegate = self
        return cell
    }
    
    func toggleRightPanel() {
        delegate?.toggleRightPanel?()
    }
}
