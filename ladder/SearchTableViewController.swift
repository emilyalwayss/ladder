//
//  SearchTableViewController.swift
//  ladder
//
//  Created by Emily Chen on 2/23/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit
import Stormpath

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courtsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var testLabel: UIStackView!
}

class SearchTableViewController: UITableViewController {
  
    var date: Date = Date()
    var users: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        queryUsers(query: "accounts") {
            users in
            self.users = users.filter { ($0["username"] as! String) != me!.username }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let format = DateFormatter()
        format.dateFormat = "EEEE, MMM d"
        self.navigationItem.title = format.string(from: date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchTableViewCell
        
        cell.profileImageView.makeCircular()
        
        let userDict = users[indexPath.row] 
        cell.nameLabel.text = userDict["givenName"] as! String?
        cell.courtsLabel.text = userDict["courts"] == nil ? "No preferred courts" : userDict["courts"] as! String
        cell.timeLabel.text = userDict["times"] == nil ? "No preferred times" : userDict["times"] as! String
        cell.responseLabel.text = userDict["response"] == nil ? "" : userDict["response"] as! String
        cell.levelLabel.text = userDict["level"] == nil ? "1" : userDict["level"] as! String
        cell.recordLabel.text = userDict["record"] == nil ? "0:0" : userDict["record"] as! String
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "searchToSearchSegue") {
            ((segue.destination as! UINavigationController).topViewController as! SearchTableViewController).date = Calendar.current.date(byAdding: .day, value: 1, to: self.date)!
        }
    }
 

}
