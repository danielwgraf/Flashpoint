//
//  DeckDetailsViewController.swift
//  Flashcards
//
//  Created by Christine Wu on 12/8/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//

import UIKit
import Alamofire

class CardDetailsViewController: UITableViewController {
    
    var card:Flashcard?
    
    @IBOutlet weak var cardWordTextField: UITextField!
    @IBOutlet weak var cardDefinitionTextField: UITextField!
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            cardWordTextField.becomeFirstResponder()
        } else if indexPath.section == 1 {
            cardDefinitionTextField.becomeFirstResponder()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveCardDetail" {
            uploadCard(id: 500, word: cardWordTextField.text!, definition: cardDefinitionTextField.text!, deck_id: 5)
            ServerAgent.sharedInstance.refresh()
            User.refresh()
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
    
    func uploadCard(id: Int, word: String, definition: String, deck_id: Int) {
        let parameters:Parameters = ["card": [
            "id": id,
            "word": word,
            "definition": definition,
            "deck_id": deck_id
            ]]
        let headers: HTTPHeaders = ["content-type": "application/json","accept": "application/json"]
        Alamofire.request("https://morning-castle-56124.herokuapp.com/cards", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            let statusCode = response.response?.statusCode
            print("Card Creation Status: ",statusCode) //201 vs 500
        })
            
        //currentUserSetup(id: id, facebook_id: facebook_id)
    }
}

