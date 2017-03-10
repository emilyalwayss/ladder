//
//  InvitationViewController.swift
//  ladder
//
//  Created by Emily Chen on 3/9/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class InvitationViewController: UIViewController {

    @IBOutlet weak var timeOfDayView: UIView!
    @IBOutlet weak var amButton: UIButton!
    @IBOutlet weak var pmButton: UIButton!
    @IBOutlet weak var startTimeView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var inviteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inviteButton.backgroundColor = Constants.Colors.ORANGE
    }

    override func viewDidLayoutSubviews() {
        timeOfDayView.layer.addBorder(edge: .bottom, color: .gray, thickness: 1.0)
        startTimeView.layer.addBorder(edge: .bottom, color: .gray, thickness: 1.0)
        locationView.layer.addBorder(edge: .bottom, color: .gray, thickness: 1.0)
    }
    
    @IBAction func timeOfDayButtonTapped(_ sender: Any) {
        let tappedButton = sender as! UIButton
        tappedButton.isSelected = true
        
        for view in timeOfDayView.subviews {
            if let btn = view as? UIButton {
                if btn != tappedButton {
                    btn.isSelected = false
                }
            }
        }
    }

    @IBAction func startTimeSliderTapped(_ sender: Any) {
        var components = DateComponents()
        components.setValue(Int(24 * 60 * (sender as! UISlider).value), for: .minute)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        self.startTimeLabel.text = formatter.string(for: Calendar.current.date(byAdding: components, to: Calendar(identifier: .gregorian).startOfDay(for: Date())))
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
