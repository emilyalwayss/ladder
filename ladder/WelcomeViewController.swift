//
//  WelcomeViewController.swift
//  ladder
//
//  Created by Emily Chen on 3/25/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Constants.Colors.BLUE
        getStartedButton.backgroundColor = Constants.Colors.ORANGE
        
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        view.addGestureRecognizer(swipeGestureRecognizer!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func swiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .right {
                self.performSegue(withIdentifier: "welcomeToLearnSegue", sender: self)
            }
        }
    }
}
