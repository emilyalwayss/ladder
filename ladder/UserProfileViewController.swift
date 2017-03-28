//
//  UserProfileViewController.swift
//  ladder
//
//  Created by Emily Chen on 3/5/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var courtLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var recordValueLabel: UILabel!
    @IBOutlet weak var skillValueLabel: UILabel!
    @IBOutlet weak var courtsValueLabel: UILabel!
    @IBOutlet weak var timesValueLabel: UILabel!
    
    var user: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recordLabel.textColor = Constants.Colors.BLUE
        skillLabel.textColor = Constants.Colors.BLUE
        courtLabel.textColor = Constants.Colors.BLUE
        timeLabel.textColor = Constants.Colors.BLUE
        inviteButton.backgroundColor = Constants.Colors.ORANGE
        
        profileImage.makeCircular()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = (user["first_name"] as! String) + " " + (user["last_name"] as! String)
        
        self.recordValueLabel.text = user["record"] == nil ? "0:0" : user["record"] as! String
        self.skillValueLabel.text = user["skill"] == nil ? "1" : user["skill"] as! String
        self.courtsValueLabel.text = user["courts"] == nil ? "No preferred courts" : (user["courts"] as! [String]).joined(separator: ", ")
        self.timesValueLabel.text = user["times"] == nil ? "No preferred times" : (user["times"] as! [String]).joined(separator: ", ")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
