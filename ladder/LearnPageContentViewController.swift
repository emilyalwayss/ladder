//
//  LearnContentViewController.swift
//  ladder
//
//  Created by Emily Chen on 3/25/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class LearnPageContentViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var goPlayButton: UIButton!
    
    var pageIndex = 0
    var strLabel = ""
    var btnIsHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Constants.Colors.BLUE
        self.goPlayButton.isHidden = btnIsHidden
        self.goPlayButton.backgroundColor = Constants.Colors.ORANGE
        
        infoLabel.font = infoLabel.font.withSize(24)
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.text = strLabel
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
