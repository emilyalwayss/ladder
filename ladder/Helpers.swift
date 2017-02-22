//
//  Helpers.swift
//  ladder
//
//  Created by Emily Chen on 2/12/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import Foundation
import UIKit
import Stormpath

struct Constants {
    static let service = "http://localhost:3000/"
    struct Colors {
        static let BLUE = UIColor(red: 100/255, green: 157/255, blue: 178/255, alpha: 1.0)
        static let ORANGE = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0)
    }
}

extension UIViewController {
    func alert(title: String = "Alert", message: String, action: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(action == nil ? UIAlertAction(title: "OK", style: .default, handler: nil) : action!)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

func getUserData (endpoint: String, completionHandler: @escaping (_ customData: [String: Any]) -> ()) {
    
    var request = URLRequest(url: URL(string: String("\(Constants.service)\(endpoint)"))!)
    request.setValue("Bearer \(Stormpath.sharedSession.accessToken ?? "")", forHTTPHeaderField: "Authorization")
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return
        }
        completionHandler(json!)
        })
    task.resume()
}
