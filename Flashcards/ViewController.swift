//
//  ViewController.swift
//  CardFlip
//
//  Created by Daniel Graf on 10/27/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        tapped()
    }
    
    @IBOutlet weak var frontLabelName: UILabel!
    
    @IBOutlet weak var cardNum: UILabel!
    
    @IBOutlet weak var backLabelName: UILabel!
    
    var index:Int = 0
    var max:Int = 0
    
    var back: UIImageView!
    var front: UIImageView!
    var showingBack = true
    var isPresented = true
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
        
        var cardInfo: [(String, String)] = deck!.getCardInfo()
        frontLabelName.text = cardInfo[index].0
        backLabelName.text = cardInfo[index].1
        cardNum.text = "\(index + 1) / \(cardInfo.count)"
        max = cardInfo.count-1
        
        
    }
    
    // MARK: Rotate
    @IBAction func dismiss() {
        isPresented = false
        self.presentingViewController!.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func next(_ sender: AnyObject) {
        if index == max {
            index = 0
        } else {
            index += 1
        }
        refresh()
    }
    
    @IBAction func prev(_ sender: AnyObject) {
        if index == 0 {
            index = max
        } else {
            index -= 1
        }
        refresh()
    }
    
    func refresh() {
        var cardInfo: [(String, String)] = deck!.getCardInfo()
        frontLabelName.text = cardInfo[index].0
        backLabelName.text = cardInfo[index].1
        cardNum.text = "\(index + 1) / \(cardInfo.count)"
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped() {
        if (showingBack) {
            UIView.transition(from: back, to: front, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
            showingBack = false
            frontLabelName.isHidden = false
            backLabelName.isHidden = true
        } else {
            UIView.transition(from: front, to: back, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
            frontLabelName.isHidden = true
            backLabelName.isHidden = false
        }
    }
}

