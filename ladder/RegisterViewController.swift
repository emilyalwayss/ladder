//
//  RegisterViewController.swift
//  ladder
//
//  Created by Emily Chen on 2/7/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.backgroundColor = Constants.Colors.ORANGE
        loginButton.tintColor = Constants.Colors.BLUE
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        createAccount(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, userEmail: emailTextField.text!, userPassword: passwordTextField.text!)
    }
    func createAccount(firstName: String, lastName: String, userEmail: String, userPassword: String) {
        AuthenticationController.sharedInstance.signUp(withEmail: emailTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, password: passwordTextField.text!, completionHandler: {(authenticationStatus, isFirstTimeUser, error) in
            switch authenticationStatus {
            case .isAuthenticated:
                self.performSegue(withIdentifier: "registerToTabSegue", sender: self)
            default:
                let alertController = UIAlertController(title: "Error", message: "Error Signing Up", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alertController, animated: true)
            }
        })
        
    }
    
}
