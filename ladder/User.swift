//
//  User.swift
//  ladder
//
//  Created by Kiko Lam on 5/7/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import Foundation

class User {
    static let idField = "_id"
    static let emailField = "email"
    static let firstNameField = "firstName"
    static let lastNameField = "lastName"
    static let passwordField = "password"
    static let tokenField = "token"
    static let skillLevelField = "skillLevel"
    static let gamesWonField = "gamesWon"
    static let gamesLostField = "gamesLost"
    static let preferredCourtsField = "preferredCourts"
    static let preferredTimesField = "preferredTimes"
    
    static let defaultKeys : [String] = [User.idField, User.emailField, User.firstNameField, User.lastNameField]
    
    var id : String
    var email : String?
    var firstName : String
    var lastName : String
    var fullName : String {
        return "\(firstName) \(lastName)"
    }
    var skillLevel : Double
    var gamesWon : Int
    var gamesLost : Int
    var preferredCourts : [String]?
    var preferredTimes : [String]?
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
        self.skillLevel = dictionary[User.skillLevelField] as? Double ?? 3.5
        self.gamesWon = dictionary[User.gamesWonField] as? Int ?? 0
        self.gamesLost = dictionary[User.gamesLostField] as? Int ?? 0
        self.preferredCourts = dictionary[User.preferredCourtsField] as? [String]
        self.preferredTimes = dictionary[User.preferredTimesField] as? [String]
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
        self.skillLevel = defaults.double(forKey: User.skillLevelField)
        self.gamesWon = defaults.integer(forKey: User.gamesWonField)
        self.gamesLost = defaults.integer(forKey: User.gamesLostField)
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
