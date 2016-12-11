//
//  ViewController.swift
//  CardFlip
//
//  Created by Daniel Graf on 10/27/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    /// Holds the image of the card
    @IBOutlet weak var cardView: UIView!
    
    /// Flips the card
    @IBAction func buttonTapped(_ sender: UIButton) {
        tapped()
    }
    
    /// Shows the word
    @IBOutlet weak var frontLabelName: UILabel!
    /// Shows the Card Number
    @IBOutlet weak var cardNum: UILabel!
    /// Shows the definition
    @IBOutlet weak var backLabelName: UILabel!
    /// Shows "Word"
    @IBOutlet weak var wordLabel: UILabel!
    /// Shows "Definition"
    @IBOutlet weak var definitionLabel: UILabel!
    
    /// Keeps track of index
    var index:Int = 0
    /// Keeps note of the deck max
    var max:Int = 0
    
    /// Back Image
    var back: UIImageView!
    /// Front Image (they're the same lol)
    var front: UIImageView!
    /// Keeps track of side
    var showingBack = false
    /// Keeps track if it's showing
    var isPresented = true
    /// Variable for the deck
    var deck:Deck?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        back = UIImageView(image: UIImage(named: "notecard_resized.jpg"))
        front = UIImageView(image: UIImage(named: "notecard_resized.jpg"))
        cardView.frame = CGRect(x: 0,y: 0,width: 100, height: 100)//(back.image?.size.width)!,height: (back.image?.size.height)!)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapped))
        singleTap.numberOfTapsRequired = 1
        
        cardView.addGestureRecognizer(singleTap)
        cardView.isUserInteractionEnabled = true
        
        cardView.addSubview(back)
        
        backLabelName.isHidden = true
        definitionLabel.isHidden = true
        
        var cardInfo: [(String, String)] = deck!.getCardInfo()
        frontLabelName.text = cardInfo[index].0
        backLabelName.text = cardInfo[index].1
        cardNum.text = "\(index + 1) / \(cardInfo.count)"
        max = cardInfo.count-1
        
        
    }
    
    // MARK: Rotate
    /// Hit the X
    @IBAction func dismiss() {
        isPresented = false
        self.presentingViewController!.dismiss(animated: true, completion: nil);
    }
    
    /// Hit the next button
    @IBAction func next(_ sender: AnyObject) {
        if index == max {
            index = 0
        } else {
            index += 1
        }
        refresh()
    }
    
    /// Hit the previous button
    @IBAction func prev(_ sender: AnyObject) {
        if index == 0 {
            index = max
        } else {
            index -= 1
        }
        refresh()
    }
    
    /// Refreshes the cards (just in case)
    func refresh() {
        var cardInfo: [(String, String)] = deck!.getCardInfo()
        frontLabelName.text = cardInfo[index].0
        backLabelName.text = cardInfo[index].1
        cardNum.text = "\(index + 1) / \(cardInfo.count)"
    }
    
    // Prevents rotation. Sticks to landscape
    override var shouldAutorotate: Bool {
        return false
    }
    
    // Basic warning thing
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// If the rotate is tapped 
    func tapped() {
        if (showingBack) {
            UIView.transition(from: back, to: front, duration: 0, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
            showingBack = false
            frontLabelName.isHidden = false
            wordLabel.isHidden = false
            backLabelName.isHidden = true
            definitionLabel.isHidden = true
        } else {
            UIView.transition(from: front, to: back, duration: 0, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
            frontLabelName.isHidden = true
            wordLabel.isHidden = true
            backLabelName.isHidden = false
            definitionLabel.isHidden = false
        }
    }
}

