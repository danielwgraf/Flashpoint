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

class CenterViewController: UIViewController { //UICollectionViewController {
    
    
    var delegate: CenterViewControllerDelegate?
    
    var Array = [String]()
    
    // MARK: Button actions
    
    @IBAction func menuTapped(_ sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
    @IBAction func studyBarTapped(_ sender: AnyObject) {
        delegate?.toggleRightPanel?()
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as UICollectionViewCell
//        
//        var Button = cell.viewWithTag(1) as! UILabel
//        Button.text = Array[indexPath.row]
//        
//        return cell
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Have the deck names appear here. Should be using Deck.deck_name in the future
        Array = ["Deck 1", "Deck 2", "Deck 3", "Deck 4"]
    }
}

extension CenterViewController: SidePanelViewControllerDelegate {
    
}

//
//import UIKit
//
//@objc
//protocol CenterViewControllerDelegate {
//  @objc optional func toggleLeftPanel()
//  @objc optional func toggleRightPanel()
//  @objc optional func collapseSidePanels()
//}
//
//class CenterViewController: UIViewController {
//
//  
//  var delegate: CenterViewControllerDelegate?
//    
//  
//  // MARK: Button actions
//  
//  @IBAction func menuTapped(_ sender: AnyObject) {
//    delegate?.toggleLeftPanel?()
//  }
//  
//  @IBAction func studyBarTapped(_ sender: AnyObject) {
//    delegate?.toggleRightPanel?()
//  }
//  
//}
//
//extension CenterViewController: SidePanelViewControllerDelegate {
//    
//}
