//
//  MeViewController.swift
//  ladder
//
//  Created by Emily Chen on 2/13/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var courtLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recordValueLabel: UILabel!
    @IBOutlet weak var skillValueLabel: UILabel!
    @IBOutlet weak var courtsValueLabel: UILabel!
    @IBOutlet weak var timesValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordLabel.textColor = Constants.Colors.BLUE
        skillLabel.textColor = Constants.Colors.BLUE
        courtLabel.textColor = Constants.Colors.BLUE
        timeLabel.textColor = Constants.Colors.BLUE
        
        profileImage.makeCircular()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = data.me.first_name + " " + data.me.last_name
//        self.navigationItem.title = "\(me!.fullName)"
        
//        getUserData(endpoint: "userData") {
//            customData in
//            self.recordValueLabel.text = customData["record"] as! String?
//            self.skillValueLabel.text = customData["skill"] as! String?
//            self.courtsValueLabel.text = customData["courts"] as! String?
//            self.timesValueLabel.text = customData["times"] as! String?
//        }
        self.recordValueLabel.text = String(data.me.win_record) + ":" + String(data.me.loss_record)
        self.skillValueLabel.text = data.me.level
        self.courtsValueLabel.text = data.me.courts.joined(separator: ", ")
        self.timesValueLabel.text = data.me.times.joined(separator: ", ")
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
