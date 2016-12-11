//
//  DeckDetailsViewController.swift
//  Flashcards
//
//  Created by Christine Wu on 12/8/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import UIKit
import Alamofire


/// VC to add a deck
class DeckDetailsViewController: UITableViewController {
    /// The created deck
    var deck:Deck?
    
    /// The field for the deck name
    @IBOutlet weak var deckNameTextField: UITextField!
    
    /// The table function. Works cause David made it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            deckNameTextField.becomeFirstResponder()
        }
    }
    
    /// Prepare for segue to save the deck
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveDeckDetail" {
            uploadDeck(id: 502, deck_name: deckNameTextField.text!, creator_id: User.id)
            ServerAgent.sharedInstance.refresh()
            User.refresh()
        }
    }
    
    /// Checks first to see if the info is good before actually performing the segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "SaveDeckDetail" {
            
            if (deckNameTextField.text?.isEmpty)! {
                let alertController = UIAlertController(title: "Error", message: "Name cannot be blank.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                present(alertController, animated: true, completion: nil)
                
                
                return false
            } else if User.getDeckNames().contains(deckNameTextField.text!){
                let alertController = UIAlertController(title: "Error", message: "There is already a deck with the name \(deckNameTextField.text!).", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                present(alertController, animated: true, completion: nil)

                return false
            }  else {
                return true
            }
        }
        
        // by default, transition
        return true
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
    
    /**
     Uploads the deck to the API
     
     - Parameters:
        - id: the deck ID (kind of unnecessary)
        - deck_name: The entered name of the deck.
        - creator_id: The ID of the user who made the deck
 
    */
    func uploadDeck(id: Int, deck_name: String, creator_id: Int) {
        let parameters:Parameters = ["deck": [
            "id": id,
            "deck_name": deck_name,
            "user_id": creator_id
            ]]
        let headers: HTTPHeaders = ["content-type": "application/json","accept": "application/json"]
        Alamofire.request("https://morning-castle-56124.herokuapp.com/decks", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            let statusCode = response.response?.statusCode
            print("Deck Creation Status: ",statusCode) //201 vs 500
        })
            
        //currentUserSetup(id: id, facebook_id: facebook_id)
    }
}


