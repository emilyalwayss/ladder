//
//  UserDataManager.swift
//  ladder
//
//  Created by Kiko Lam on 5/14/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//


import Foundation

class UserDataManager : DataManager {
    
    static let displayUsernameField = "displayUsername"
    static let profilePhotoField = "profilePhoto"
    
    static let sharedInstance = UserDataManager()
    
    override func getData(andUpdate: Bool = true) -> [AnyHashable : Any]? {
        return super.getData(andUpdate: andUpdate)
    }
    
    func getDisplayUsername() -> String? {
        return getData()?[UserDataManager.displayUsernameField] as? String
    }
    
    func getProfilePhoto() -> String? {
        return getData()?[UserDataManager.profilePhotoField] as? String
    }
}

extension UserDataManager : DataManagerProtocol {
    var notificationOnSuccess: Notification.Name {
        get { return Notification.Name.UserDataManagerLoad}
    }
    
    var notificationOnFailure: Notification.Name {
        get { return Notification.Name.UserDataManagerLoadFailed}
    }
    
    func fetchDataFromAPI(completionHandler: @escaping DataManagerHandler) {
        RequestHandler.request(endpoint: "profile", method: .get, parameters: nil, completionHandler: self.getCompletionHandlerForAPI({(response, success, error) in
            if success {
                completionHandler(response, true, nil)
            } else {
                completionHandler(nil, false, error)
            }
        })
        )
    }
}

extension Notification.Name {
    static let UserDataManagerLoad = Notification.Name("UserDataManagerLoad")
    static let UserDataManagerLoadFailed = Notification.Name("UserDataManagerLoadFailed")
}
