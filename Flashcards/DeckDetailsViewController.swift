//
//  DeckDetailsViewController.swift
//  Flashcards
//
//  Created by Christine Wu on 12/8/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import UIKit

class DeckDetailsViewController: UITableViewController {
    
    var deck:Deck?
    
    @IBOutlet weak var deckNameTextField: UITextField!
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            deckNameTextField.becomeFirstResponder()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveDeckDetail" {
            let destViewController = segue.destination as? CenterViewController
            let newDeck = Deck(id:500, deck_name: deckNameTextField.text!, creator_id:1)
            destViewController?.newDeck = newDeck
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
