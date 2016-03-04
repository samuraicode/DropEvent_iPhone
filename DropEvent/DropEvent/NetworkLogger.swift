//
//  NetworkLogger.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/27/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import RxMoya
import Result

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
//                print("Sending request: \(String(data: (request.request?.HTTPBody)!, encoding: NSUTF8StringEncoding)  ?? String()) \n")
                print("request headers: \(request.request?.allHTTPHeaderFields)")
        //        print("Sending request: \(request.request?.URL?.absoluteString ?? String()) \n")
    }
    
    func didReceiveResponse(result: Result<RxMoya.Response, RxMoya.Error>, target: TargetType) {
        //        // If the target is in the blacklist, don't log it.
        ////        guard blacklist(target) == false else { return }
        ////
        ////        switch result {
        ////        case .Success(let response):
        ////            if 200..<400 ~= (response.statusCode ?? 0) {
        ////                // If the status code is OK, and if it's not in our whitelist, then don't worry about logging its response body.
        ////                print("Received response(\(response.statusCode ?? 0)) from \(response.response?.URL?.absoluteString ?? String()). \n")
        ////            }
        ////        case .Failure(let error):
        ////            // Otherwise, log everything.
        ////            print("Received networking error: \(error)")
        ////        }
    }
}
