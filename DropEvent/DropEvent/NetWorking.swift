//
//  NetWorking.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/22/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import RxMoya

class LoginNetworking {
    private let endpointClosure = { (target: DropEvent) -> Endpoint<DropEvent> in
        return Endpoint<DropEvent>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: RxMoya.ParameterEncoding.JSON, httpHeaderFields: ["Content-Type":"x-www-form-urlencoded"])
    }
    let provider: RxMoyaProvider<DropEvent>
    
    init() {
        provider = RxMoyaProvider(endpointClosure: self.endpointClosure, plugins: [NetworkLogger()])
    }
}


class NetWorking {
    private let endpointClosure = { (target: DropEvent) -> Endpoint<DropEvent> in
        let endpoint = Endpoint<DropEvent>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
        return endpoint
    }
    
    let provider: RxMoyaProvider<DropEvent>
    
    init() {
        provider = RxMoyaProvider(endpointClosure: self.endpointClosure, plugins: [NetworkLogger()])
    }
}


class AuthenticatedNetworking {
    
    var provider: RxMoyaProvider<DropEventAuth>

    init(user: UserModel = UserModel.sharedInstance) {
        
        let endpointClosure = { (target: DropEventAuth) -> Endpoint<DropEventAuth> in
            let endpoint: Endpoint<DropEventAuth> = Endpoint<DropEventAuth>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
            return endpoint.endpointByAddingHTTPHeaderFields(["x-access-token": user.sessionToken])
        }
        
        self.provider = RxMoyaProvider(endpointClosure:endpointClosure, plugins: [NetworkLogger()])
    }
    
}
