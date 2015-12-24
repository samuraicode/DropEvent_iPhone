//
//  EventAPI.swift
//  DropEvent
//
//  Created by Jesse Gatt on 12/24/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON


class EventAPI {
    
    func getEvent() -> Observable<EventModel> {
        return create({ observable in
            Alamofire.request(.GET, "https://dropevent.com/api/dropevent/sample").responseJSON(completionHandler: { response in
                if let json = response.result.value {
                   observable.onNext(EventModel(json: JSON(json)))
                }
                
            })
            
            return AnonymousDisposable {
            }
        })
    }
    
}