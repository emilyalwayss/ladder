//
//  RequestHandler.swift
//  ladder
//
//  Created by Kiko Lam on 5/14/17.
//  Copyright © 2017 Emily Chen. All rights reserved.
//

import Foundation
import Alamofire

class RequestHandler {
    static let apiPrefix = "https://ladder-user.herokuapp.com/"
    
    static func request(endpoint: String, method: HTTPMethod = .get, parameters: [String : Any]? = nil, completionHandler: @escaping (DataResponse<Any>, Bool) -> Void) {
        guard let token = AuthenticationController.sharedInstance.token else {
            return
        }
        
        let headers : HTTPHeaders = [
//            "Accept": "application/json; charset=UTF-8",
//                                     "Content-Type": "application/json",
                                     "Authorization": "Bearer \(token)"
//                                     "Content-Length": "76",
//                                     "Accept-Encoding": "gzip, deflate, br",
//                                     "Accept-Language": "en-US,en;q=0.8"
        ]
        
        do {
            var urlRequest = try URLRequest(url: URL(string:"\(apiPrefix)\(endpoint)")!, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData // <- Cache disabled
            let encodedURLRequest = try (JSONEncoding.default).encode(urlRequest, with: parameters)
            
            Alamofire.request(encodedURLRequest).validate(contentType: ["application/json"]).responseJSON(completionHandler: {response in
                if response.response?.statusCode == 401 {
                    NotificationCenter.default.post(name: .UserTokenExpired, object: nil)
                } else {
                    completionHandler(response, response.result.isSuccess && response.isStatusCodeSuccess)
                }
            })
            
        } catch {
            print(error)
        }
    }
    
    static func unauthenticatedRequest(endpoint: String, method: HTTPMethod = .get, parameters: [String : Any]? = nil, completionHandler: @escaping (DataResponse<Any>, Bool) -> Void) {
        let headers : HTTPHeaders = ["Accept": "application/json", "Content-Type": "application/json"]
        Alamofire.request("\(apiPrefix)\(endpoint)", method: method, parameters: parameters as Parameters?, encoding: JSONEncoding.default, headers: headers).validate(contentType: ["application/json"]).responseJSON(completionHandler: {response in
            completionHandler(response, response.result.isSuccess && response.isStatusCodeSuccess)
        })
    }
}

extension DataResponse {
    var isStatusCodeSuccess : Bool {
        return response?.statusCode != nil && response!.statusCode >= 200 && response!.statusCode <= 299
    }
}

extension Notification.Name {
    static let UserTokenExpired = Notification.Name("EDUserTokenExpired")
}
