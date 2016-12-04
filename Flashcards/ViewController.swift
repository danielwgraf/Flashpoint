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
    
    var back: UIImageView!
    var front: UIImageView!
    
    var showingBack = true
    
    var isPresented = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        back = UIImageView(image: UIImage(named: "Notecard.jpg"))
        front = UIImageView(image: UIImage(named: "front-1.png"))
        cardView.frame = CGRect(x: 20,y: 20,width: (back.image?.size.width)!,height: (back.image?.size.height)!)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapped))
        singleTap.numberOfTapsRequired = 1
        
        cardView.addGestureRecognizer(singleTap)
        cardView.isUserInteractionEnabled = true
        
       cardView.addSubview(back)
        
        
        
        
    }
    
    // MARK: Rotate
    @IBAction func dismiss() {
        isPresented = false
        self.presentingViewController!.dismiss(animated: true, completion: nil);
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
        } else {
            UIView.transition(from: front, to: back, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
        }
    }
    
}

