//
//  DataManager.swift
//  ladder
//
//  Created by Kiko Lam on 5/14/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import Foundation
import Alamofire

protocol DataManagerProtocol {
    var notificationOnSuccess: Notification.Name { get }
    var notificationOnFailure: Notification.Name { get }
    
    func fetchDataFromAPI(completionHandler: @escaping DataManager.DataManagerHandler)
}

protocol ModifiableDataManagerProtocol {
    associatedtype ItemType
    func selectAll() -> [ItemType]?
    func getItem(byId id: String) -> ItemType?
    func upsert(item: ItemType)
    func delete(item: ItemType)
    func replaceAll(fromDictionary dictionary: [AnyHashable : Any])
    func didOverrideSetDataResetData() -> Bool
}

class DataManager : NSObject {
    public typealias DataManagerHandler = (_ response: [AnyHashable : Any]?, _ success: Bool, _ error: Error?) -> Void
    
    private var lastRetrieved = Date(timeIntervalSince1970: 0)
    private var data : [AnyHashable : Any]?
    private var isFetching = false
    var hasMostRecentRequestFailed = false
    
    var isOutOfDate : Bool {
        return data == nil || lastRetrieved == Date(timeIntervalSince1970: 0)
    }
    
    func getData(andUpdate: Bool = true) -> [AnyHashable : Any]? {
        if andUpdate {
            updateOutOfDateData()
        }
        return data
    }
    
    func setData(_ data : [AnyHashable : Any]) {
        self.data = data
    }
    
    func onSignOut() {
        resetData()
    }
    
    func resetData() {
        // TODO cancel outstanding requests
        lastRetrieved = Date(timeIntervalSince1970: 0)
        data = nil
    }
    
    func updateOutOfDateData() {
        if isOutOfDate {
            updateData()
        }
    }
    
    func updateData(force: Bool = false) {
        // if needs to fetch score
        guard !isFetching || force else {
            return
        }
        guard let dmp = self as? DataManagerProtocol else {
            return
        }
        isFetching = true
        dmp.fetchDataFromAPI(completionHandler: {(response, success, error) in
            self.isFetching = false
            if success && response != nil {
                self.saveData(response: response!)
                self.hasMostRecentRequestFailed = false
                NotificationCenter.default.post(name: dmp.notificationOnSuccess, object: nil)
            } else {
                self.hasMostRecentRequestFailed = true
                NotificationCenter.default.post(name: dmp.notificationOnFailure, object: error)
            }
        })
    }
    
    func saveData(response : [AnyHashable : Any]) {
        self.lastRetrieved = Date()
        self.setData(response)
    }
    
    func getCompletionHandlerForAPI(_ completionHandler: @escaping DataManagerHandler) -> ((DataResponse<Any>, Bool) -> Void) {
        return {(response, success) in
            if success {
                if let json = response.result.value as? [AnyHashable : Any] {
                    completionHandler(json, true, nil)
                } else {
                    completionHandler(nil, false, nil)
                }
            } else {
                completionHandler(nil, false, response.result.error)
            }
        }
    }
}
