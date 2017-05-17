//
//  AuthenticationController.swift
//  ladder
//
//  Created by Kiko Lam on 5/14/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import Foundation
import KeychainAccess

public enum AuthenticationStatus {
    case isAuthenticated
    case isNotAuthenticated
}

public typealias AuthenticationHandler = (_ status: AuthenticationStatus, _ isFirstTimeUser: Bool, _ error: Error?) -> Void

class AuthenticationController {
    static let sharedInstance = AuthenticationController()
    
    private let keychain = Keychain(service: "com.heroku.ladder-user")
    var token : String?
    var user : User?
    
    init() {
        user = User(fromUserDefaults: UserDefaults.standard)
    }
    
    func getAuthenticationStatus() -> AuthenticationStatus {
        return user == nil ? .isNotAuthenticated : .isAuthenticated
    }
    
    private func setUser(fromDictionary dictionary: [AnyHashable : Any]) {
        user = User(fromDictionary: dictionary)
        user?.write(toUserDefaults: UserDefaults.standard)
    }
    
    func signUp(withEmail email: String, firstName: String, lastName: String, password: String, completionHandler: @escaping AuthenticationHandler) {
        let request = [User.firstNameField: firstName,
                       User.lastNameField: lastName,
                       User.emailField: email,
                       User.passwordField: password]
        RequestHandler.unauthenticatedRequest(endpoint: "api/register", method: .post, parameters: request, completionHandler: {(response, success) in
            if success {
                var isFirstTimeUser = true
                if let json = response.result.value as? [AnyHashable : Any] {
                    self.setUser(fromDictionary: json)
                    if let isExistingUser = json["isExistingUser"] as? Bool {
                        isFirstTimeUser = !isExistingUser
                    }
                }
                if isFirstTimeUser {
                    // TODO
                }
                completionHandler(self.getAuthenticationStatus(), isFirstTimeUser, nil)
            } else if response.response?.statusCode == 403 {
                // user exists already - send the code unmodified
            } else {
                completionHandler(self.getAuthenticationStatus(), false, response.result.error)
            }
        })
    }
    
    
    func checkIfUserExists(forEmail email: String, completionHandler: @escaping AuthenticationHandler) {
        // TODO
    }
    
    func signIn(withEmail email: String, password: String, completionHandler: @escaping AuthenticationHandler) {
        
        let request = [User.emailField: email,
                       User.passwordField: password]

        RequestHandler.unauthenticatedRequest(endpoint: "api/login", method: .post, parameters: request, completionHandler: {(response, success) in
            if success {
                if let json = response.result.value as? [AnyHashable : Any] {
                    self.setUser(fromDictionary: json)
                }
                completionHandler(self.getAuthenticationStatus(), false, nil)
            } else {
                completionHandler(self.getAuthenticationStatus(), false, response.result.error)
            }
        })
    }
    
    func signOut() {
        token = nil
        user?.signOut(ofUserDefaults: UserDefaults.standard)
        user = nil
    }
}

