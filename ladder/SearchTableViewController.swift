//
//  SearchTableViewController.swift
//  ladder
//
//  Created by Emily Chen on 2/23/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courtsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
}

class SearchTableViewController: UITableViewController {
  
    @IBOutlet weak var backBarButtonItem: UIBarButtonItem!
    
    var date: Date = Date()
    var users: [[String: Any]] = []
    var selectedIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        queryUsers(query: "accounts") {
//            users in
//            self.users = users.filter { ($0["username"] as! String) != me!.username }
//            self.tableView.reloadData()
//        }
        for user in data.users {
            var dic: [String: Any] = [:]
            for (_, attr) in Mirror(reflecting: user).children.enumerated() {
                dic[attr.label!] = attr.value
            }
            users.append(dic)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let format = DateFormatter()
        format.dateFormat = "EEEE, MMM d"
        self.navigationItem.title = format.string(from: date)
        
        backBarButtonItem.isEnabled = format.string(from: date) != format.string(from: Date())
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
        cell.nameLabel.text = (userDict["first_name"] as! String) + " " + (userDict["last_name"] as! String)
        cell.courtsLabel.text = userDict["courts"] == nil ? "No preferred courts" : (userDict["courts"] as! [String]).joined(separator: ", ")
        cell.timeLabel.text = userDict["times"] == nil ? "No preferred times" : (userDict["times"] as! [String]).joined(separator: ", ")
        cell.responseLabel.text = userDict["response"] == nil ? "" : userDict["response"] as! String
        cell.levelLabel.text = userDict["level"] == nil ? "1" : userDict["level"] as! String
        cell.recordLabel.text = userDict["record"] == nil ? "0:0" : userDict["record"] as! String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "searchToProfileSegue", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "searchForwardSegue") {
             ((segue.destination as! UINavigationController).topViewController as! SearchTableViewController).date = Calendar.current.date(byAdding: .day, value: 1, to: self.date)!
        }
        else if (segue.identifier == "searchBackSegue") {
            ((segue.destination as! UINavigationController).topViewController as! SearchTableViewController).date = Calendar.current.date(byAdding: .day, value: -1, to: self.date)!
        }
        else if (segue.identifier == "searchToProfileSegue") {
            let profileViewController = (segue.destination as! UINavigationController).topViewController as! UserProfileViewController
            profileViewController.user = users[selectedIndex]
            
        }
    }
 

}
