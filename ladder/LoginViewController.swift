//
//  LoginViewController.swift
//  ladder
//
//  Created by Emily Chen on 2/20/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.backgroundColor = Constants.Colors.ORANGE
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            self.alert(message: "Please fill out email and password.")
            return
        }
        login(userEmail: email, userPassword: password)
    }
    
    func login(userEmail: String, userPassword: String) {
        self.performSegue(withIdentifier: "loginToTabSegue", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginToTabSegue") {
            (segue.destination as! UITabBarController).selectedIndex = 3
        }
    }
}
