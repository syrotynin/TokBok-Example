//
//  ServiceManager.swift
//  Basic-Video-Chat
//
//  Created by Serhii Syrotynin on 8/8/17.
//  Copyright © 2017 tokbox. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    /// Return an OpenTok API key, session ID, and token.
    case session
    /// Return an OpenTok API key, session ID, and token associated with a room name.
    case room(name: String)
    
    static let baseURLString = "https://young-atoll-75457.herokuapp.com"
    
    var method: HTTPMethod {
        switch self {
        case .session:
            return .get
        case .room:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .session:
            return "/session"
        case .room(let name):
            return "/room/:\(name)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
