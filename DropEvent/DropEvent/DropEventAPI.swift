//
//  DropEventAPI.swift
//  DropEvent
//
//  Created by Jesse Gatt on 1/17/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import RxMoya

private let DropEventBaseURL = "https://dropevent.com/api"
//private let DropEventBaseURL = "https://dropevent.ngrok.io/api"


enum DropEvent {
    case Login(email: String, password: String)
    case Search(searchTerm: String)
}

extension DropEvent: TargetType {
    var baseURL: NSURL {return NSURL(string: DropEventBaseURL)!}
    
    var path: String {
        switch self {
        case .Login:
            return "/login"
        case .Search(let searchTerm):
            return "/search/\(searchTerm)"
        }
    }
    
    var method: RxMoya.Method {
        switch self {
        case .Login:
            return .POST
        default:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .Login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default:
            return nil
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .Login:
            return "sample".dataUsingEncoding(NSUTF8StringEncoding)!
        case .Search:
            return "search".dataUsingEncoding(NSUTF8StringEncoding)!
            
        }
    }
}


func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}


let endpointClosure = { (target: DropEvent) -> Endpoint<DropEvent> in
    let endpoint = Endpoint<DropEvent>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    return endpoint
}


enum DropEventAuth {
    case GetEvents
}

extension DropEventAuth: TargetType {
    var baseURL: NSURL {return NSURL(string: DropEventBaseURL)!}
    
    var path: String {
        switch self {
        case .GetEvents:
            return "/dropevent"
        }
    }
    
    var method: RxMoya.Method {
        switch self {
        case .GetEvents:
            return .GET
        default:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .GetEvents:
            return nil
        default:
            return nil
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .GetEvents:
            return "sample".dataUsingEncoding(NSUTF8StringEncoding)!
            
        }
    }
}



