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

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
    }
  
  var delegate: CenterViewControllerDelegate?
    
    //User.decks.names
    var cardLabels: [String] = ["Deck 1", "Deck 2", "Deck3", "Deck4", "Deck5", "Deck6"]
    var cardImages: [String] = ["back-1.png"]
    
  
  // MARK: Button actions
  
  @IBAction func menuTapped(_ sender: AnyObject) {
    delegate?.toggleLeftPanel?()
  }
  
  @IBAction func studyBarTapped(_ sender: AnyObject) {
    delegate?.toggleRightPanel?()
    }
  
    
}

extension CenterViewController: SidePanelViewControllerDelegate {
    
}

extension CenterViewController: UICollectionViewDataSource, DeckCardCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //User.decks.count
        return 6
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
