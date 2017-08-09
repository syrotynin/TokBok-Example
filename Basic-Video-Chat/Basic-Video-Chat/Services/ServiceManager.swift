//
//  ServiceManager.swift
//  Basic-Video-Chat
//
//  Created by Serhii Syrotynin on 8/8/17.
//  Copyright © 2017 tokbox. All rights reserved.
//

import Foundation
import Alamofire

struct ServerKeys {
    static let apiKey = "apiKey"
    static let sessionId = "sessionId"
    static let token = "token"
}

class ServiceManager {
    static let shared = ServiceManager()
    private init() {}
    
    public var apiKey: String?
    public var sessionId: String?
    public var token: String?
    
    func startSession(completion: @escaping ()->()) {
        Alamofire.request(Router.session).responseJSON { response in
            if let json = response.result.value as? [String: String] {
                print("JSON: \(json)") // serialized json response
                
                self.apiKey = json[ServerKeys.apiKey]
                self.sessionId = json[ServerKeys.sessionId]
                self.token = json[ServerKeys.token]
            }
            completion()
        }
    }
}
