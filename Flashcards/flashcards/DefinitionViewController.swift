//
//  DefinitionViewController.swift
//  Flashcards
//
//  Created by David S Gao on 9/26/16.
//  Copyright © 2016 David S Gao. All rights reserved.
//

import UIKit

class DefinitionViewController: UIViewController {
    
    @IBOutlet weak var commandLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    var flashcard: Flashcard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // we need to safely unpack the flashcard and display the data, if present
        if let card = flashcard {
            commandLabel.text = card.command
            definitionLabel.text = card.definition
        }
    }
}