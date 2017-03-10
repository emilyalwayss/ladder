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

var me: Account? = nil

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

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.frame.width, height: thickness))
        case UIRectEdge.bottom:
            border.frame = CGRect(origin: CGPoint(x: 0, y: self.frame.height - thickness), size: CGSize(width: self.frame.width, height: thickness))
        case UIRectEdge.left:
            border.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: thickness, height: self.frame.height))
        case UIRectEdge.right:
            border.frame = CGRect(origin: CGPoint(x: self.frame.width - thickness, y: 0), size: CGSize(width: thickness, height: self.frame.height))
        default:
            break
        }
        
        border.backgroundColor = color.cgColor
        
        self.addSublayer(border)
    }
}

extension UIImageView {
    func makeCircular() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
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

func queryUsers (query: String, completionHandler: @escaping (_ result: [[String: Any]]) -> ()) {
    
    let username = "6IIZJZ2JHHCJ9ZXLEXXINJREI"
    let password = "2IMWSbZXAYpMda0f4/S5aqzWJ6YXT+ljxTMX9GgjR44"
    let loginString = String(format: "%@:%@", username, password)
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()
    
    // create the request
    let url = URL(string: "https://api.stormpath.com/v1/applications/4KIXjEmVwXS6VpmZ6xOouq/accounts")!
    var request = URLRequest(url: url)
    request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    
    // fire off the request
    // make sure your class conforms to NSURLConnectionDelegate
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return
        }
        completionHandler(json!["items"] as! [[String: Any]])
    })
    task.resume()
}
