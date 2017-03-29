//
//  WelcomeViewController.swift
//  ladder
//
//  Created by Emily Chen on 3/25/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit
import QuartzCore

class WelcomeViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Constants.Colors.BLUE
        getStartedButton.backgroundColor = Constants.Colors.ORANGE
        
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(WelcomeViewController.swiped(_:)))
        swipeGestureRecognizer?.direction = .left
        view.addGestureRecognizer(swipeGestureRecognizer!)
    }
    
    func swiped(_ gesture: UIGestureRecognizer) {
        self.performSegue(withIdentifier: "welcomeToLearnSegue", sender: self)
    }
}
