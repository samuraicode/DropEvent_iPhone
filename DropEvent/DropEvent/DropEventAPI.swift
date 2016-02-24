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
//
//static func endpointsClosure<T where T: TargetType, T: ArtsyAPIType>(xAccessToken: String? = nil)(_ target: T) -> Endpoint<T> {
//    var endpoint: Endpoint<T> = Endpoint<T>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
//    
//    // If we were given an xAccessToken, add it
//    if let xAccessToken = xAccessToken {
//        endpoint = endpoint.endpointByAddingHTTPHeaderFields(["X-Access-Token": xAccessToken])
//    }
//    
//    // Sign all non-XApp, non-XAuth token requests
//    if target.addXAuth {
//        return endpoint.endpointByAddingHTTPHeaderFields(["X-Xapp-Token": XAppToken().token ?? ""])
//    } else {
//        return endpoint
//    }
//}
//
//let authEndpointClosure = { (target: DropEventAuth) -> Endpoint<DropEventAuth> in
//    let endpoint = Endpoint<DropEventAuth>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: RxMoya.ParameterEncoding.JSON, httpHeaderFields: ["x-access-token":target.parameters["sessionToken"]])
//    return endpoint
//}


class NetworkLogger: PluginType {
    
    typealias Comparison = TargetType -> Bool
    
    let whitelist: Comparison
    let blacklist: Comparison
    
    init(whitelist: Comparison = { _ -> Bool in return true }, blacklist: Comparison = { _ -> Bool in  return true }) {
        self.whitelist = whitelist
        self.blacklist = blacklist
    }
    
    func willSendRequest(request: RequestType, target: TargetType) {
        // If the target is in the blacklist, don't log it.
//        guard blacklist(target) == false else { return }
//        print("Sending request: \(String(data: (request.request?.HTTPBody)!, encoding: NSUTF8StringEncoding)  ?? String()) \n")
//        print("request headers: \(request.request?.allHTTPHeaderFields)")
//        print("Sending request: \(request.request?.URL?.absoluteString ?? String()) \n")
    }
    
    func didReceiveResponse(result: Result<RxMoya.Response, RxMoya.Error>, target: TargetType) {
        // If the target is in the blacklist, don't log it.
//        guard blacklist(target) == false else { return }
//        
//        switch result {
//        case .Success(let response):
//            if 200..<400 ~= (response.statusCode ?? 0) {
//                // If the status code is OK, and if it's not in our whitelist, then don't worry about logging its response body.
//                print("Received response(\(response.statusCode ?? 0)) from \(response.response?.URL?.absoluteString ?? String()). \n")
//            }
//        case .Failure(let error):
//            // Otherwise, log everything.
//            print("Received networking error: \(error)")
//        }
    }
}


