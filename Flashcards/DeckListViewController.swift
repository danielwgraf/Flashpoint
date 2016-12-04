//
//  DeckListViewController.swift
//  Flashcards
//
//  Created by Daniel Graf on 11/17/16.
//  Copyright © 2016 Daniel Graf. All rights reserved.
//


import UIKit

extension DeckListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}


class DeckListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel = DeckListViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        viewModel.refresh()
//        viewModel.refresh { [unowned self] in
//            dispatch_get_main_queue().asynchronously() {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        //cell.textLabel?.text = viewModel.titleForRowAtIndexPath(indexPath)
        cell.title?.text = viewModel.titleForRowAtIndexPath(indexPath: indexPath as NSIndexPath)
        return cell
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let detailVC = segue.destinationViewController as? RepositoryDetailViewController,
//            let cell = sender as? UITableViewCell,
//            let indexPath = tableView.indexPath(for: cell) {
//            detailVC.viewModel = viewModel.detailViewModelForRowAtIndexPath(indexPath)
//        }
//    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red:0.98, green:0.48, blue:0.24, alpha:1.0)
        // searchController.searchBar.becomeFirstResponder()
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        viewModel.updateFiltering(searchText: searchText)
        tableView.reloadData()
    }
    
}


