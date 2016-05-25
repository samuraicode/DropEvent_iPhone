//
//  SearchEventsViewModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/8/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import RxSwift
import RxMoya
import SwiftyJSON


class SearchEventsViewModel  {
    
    let disposeBag = DisposeBag()
    
    var events: [EventSearchModel]
    
    var dropEventProvider: RxMoyaProvider<DropEvent>
    
    
    init() {
        dropEventProvider = RxMoyaProvider(endpointClosure: endpointClosure, plugins: [])
        self.events = []
        
    }
    
    func findEvents(searchTerm: String) -> Observable<Bool> {
        return dropEventProvider.request(.Search(searchTerm: searchTerm)).observeOn(MainScheduler.instance).map({ response in
            switch response.statusCode {
            case 200:
                if let eventsReturned = JSON(data: response.data).array {
                    self.events = eventsReturned.map { eventData in
                        return EventSearchModel(json:eventData)//EventModel()
                    }
                    if self.events.count > 0 {
                        return true
                    }
                    return false
                }else {
                    return false
                }
            default:
                return false
            }
        })
    }
    
    func numberOfTableRows() -> Int {
        return self.events.count
    }
    
    func eventFor(indexPath: NSIndexPath) -> EventSearchModel {
        return self.events[indexPath.row]
    }
    
}