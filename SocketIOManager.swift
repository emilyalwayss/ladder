//
//  SocketIOManager.swift
//  
//
//  Created by Emily Chen on 3/7/17.
//
//

import UIKit

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = SocketIOClient(socketUrl: NSURL(string: "http://192.168.1.8:3000")!)
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }

}
