//
//  JournalListTableViewController.swift
//  JournalCloudKit
//
//  Created by tyson ericksen on 12/9/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import UIKit

class JournalListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        JournalController.shared.fetchEntry { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalListCell", for: indexPath)

        let entry = JournalController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title

        return cell
    }
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   */
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryDetailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? EntryDetailViewController {
                    let entry = JournalController.shared.entries[indexPath.row]
                    destinationVC.entries = entry
                }
            }
        }
    }
}
