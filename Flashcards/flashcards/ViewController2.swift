//
//  ViewController.swift
//  Flashcards
//
//  Created by David S Gao on 9/26/16.
//  Copyright © 2016 David S Gao. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var commandLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let flashcard = deck.drawRandomCard() {
            self.flashcard = flashcard
            commandLabel.text = flashcard.command
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let flashcard = deck.drawRandomCard() {
            self.flashcard = flashcard
            commandLabel.text = flashcard.command
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDefinition" {
            let showDefinition:DefinitionViewController = segue.destination as! DefinitionViewController
            showDefinition.flashcard = self.flashcard
        }
    }
    
    let deck = Deck()
    var flashcard: Flashcard?

}

