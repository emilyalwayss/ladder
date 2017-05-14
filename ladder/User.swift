//
//  User.swift
//  ladder
//
//  Created by Kiko Lam on 5/7/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import Foundation

class User {
    static let idField = "id"
    static let emailField = "email"
    static let firstNameField = "firstName"
    static let lastNameField = "lastName"
    static let tokenField = "token"
    
    static let defaultKeys : [String] = [User.idField, User.emailField, User.firstNameField, User.lastNameField]
    
    var id : String
    var email : String?
    var firstName : String
    var lastName : String
    var fullName : String {
        return "\(firstName) \(lastName)"
    }
    var profilePhoto : String?
    
    init?(fromDictionary dictionary: [AnyHashable : Any]) {
        guard let id = dictionary[User.idField] as? String,
            let firstName = dictionary[User.firstNameField] as? String,
            let lastName = dictionary[User.lastNameField] as? String else {
                return nil
        }
        self.id = id
        self.email = dictionary[User.emailField] as? String
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init?(fromUserDefaults defaults: UserDefaults) {
        guard let id = defaults.string(forKey: User.idField),
            let firstName = defaults.string(forKey: User.firstNameField),
            let lastName = defaults.string(forKey: User.lastNameField) else {
                return nil
        }
        self.id = id
        self.email = defaults.string(forKey: User.emailField)
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func write(toUserDefaults defaults: UserDefaults) {
        defaults.set(id, forKey: User.idField)
        defaults.set(email, forKey: User.emailField)
        defaults.set(firstName, forKey: User.firstNameField)
        defaults.set(lastName, forKey: User.lastNameField)
    }
    
    func signOut(ofUserDefaults defaults: UserDefaults) {
        for key in User.defaultKeys {
            defaults.removeObject(forKey: key)
        }
    }
}
