//
//  SearchController.swift
//  ladder
//
//  Created by Emily Chen on 5/18/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import Foundation

class SearchController {
    static let sharedInstance = SearchController()
    
    var users : [User]
    
    init() {
        users = []
    }
    
    func getAllUsers() {
        RequestHandler.request(endpoint: "api/users") {(response, success) in
            if success {
                if let json = response.result.value as? [AnyHashable : Any],
                    let userList = json["userList"] as? [Any]{
                    for item in userList {
                        if let user = item as? [AnyHashable : Any] {
                            self.users.append(User(fromDictionary: user)!)
                        }
                    }
                }
            }
            else {
            }
            
        }
    }
}
