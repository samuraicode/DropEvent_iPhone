//
//  EventsViewModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/8/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import RxSwift
import RxMoya
import SwiftyJSON

class EventsViewModel {
    
    let disposeBag = DisposeBag()
    
    var myEvents: [EventModel]
    var contributedEvents: [EventModel]
    
    var authNetworker: AuthenticatedNetworking
    
    var eventsChanged: Observable<Bool>
    
    init() {
        self.myEvents = []
        self.contributedEvents = []
        self.authNetworker = AuthenticatedNetworking()
        eventsChanged = just(false)
        if !UserModel.sharedInstance.sessionToken.isEmpty {
            self.updateEventsChanged()
        }
    }
    
    func updateEventsChanged() {
        eventsChanged = authNetworker.provider.request(.GetEvents).observeOn(MainScheduler.sharedInstance).map({ response in
            switch response.statusCode {
            case 200:
                let eventsReturned = JSON(data: response.data)
                if let myEventsReturned = eventsReturned["Mine"].array {
                    self.myEvents = myEventsReturned.map {
                        return EventModel(json: $0)
                    }
                }
                
                if let contributedEventsReturned = eventsReturned["Contributed"].array {
                    self.contributedEvents = contributedEventsReturned.map {
                        return EventModel(json: $0)
                    }
                }
                if self.myEvents.count > 0 || self.contributedEvents.count > 0 {
                    return true
                }else {
                   return false
                }
            default:
                return false
            }
        })
    }
    
    var numberOfSections: Int {
        get {
            return 1 + self.contributedEvents.count > 0 ? 1 : 0
        }
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        switch section {
        case 0:
            return self.myEvents.count
        case 1:
            return self.contributedEvents.count
        default:
            return 0
        }
    }
    
    func event(forIndexPath indexPath: NSIndexPath) -> EventModel {
        return self.myEvents[indexPath.row]
    }

    
}
