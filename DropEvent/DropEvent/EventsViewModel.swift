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
import CoreStore

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
        eventsChanged = Observable.just(false)
        if let user =  UserDBModel.fetchUser() {
            if let myEvents = user.myEvents {
                self.myEvents = Array(myEvents)
            }
            if let contributedEvents = user.contributedEvents {
                self.contributedEvents = Array(contributedEvents)
            }
            if !user.sessionToken.isEmpty {
                self.updateEventsChanged()
            }
        }
        
    }
    
    func updateEventsChanged() {
        eventsChanged = authNetworker.provider.request(.GetEvents).map({ response -> Bool in
            switch response.statusCode {
            case 200:
                let eventsReturned = JSON(data: response.data)
                let eventsTuple = self.add(eventsReturned["Mine"].array, contributedEventsJson: eventsReturned["Contributed"].array)
                self.myEvents = eventsTuple.myEvent
                self.contributedEvents = eventsTuple.contributedEvent
                
                if self.myEvents.count > 0 || self.contributedEvents.count > 0 {
                    return true
                }else {
                   return false
                }
            default:
                return false
            }
        }).observeOn(MainScheduler.instance)
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
    
    func add(myEventsJson: [JSON]?, contributedEventsJson: [JSON]?) -> (myEvent:[EventModel],contributedEvent:[EventModel]) {
        var newMyEvents: [EventModel] = []
        var newContributedEvents: [EventModel] = []
        CoreStore.beginSynchronous { (transaction) -> Void in
            if let user = transaction.fetchOne(From(UserDBModel)) {
                if let uwMyEvents = user.myEvents {
                    transaction.delete(uwMyEvents)
                }
                if let uwContributedEvents = user.contributedEvents {
                    transaction.delete(uwContributedEvents)
                }
                
                let addEventsToTransaction: ((eventsJson:[JSON]?) -> [EventModel]) = { eventsJson in
                    var events: [EventModel] = []
                    if let eventsJsonUnwrapped = eventsJson {
                        for eventJson in eventsJsonUnwrapped {
                            let newEventModel: EventModel = transaction.create(Into(EventModel))
                            newEventModel.populate(eventJson)
                            if let foldersJson = eventJson["folders"].array {
                                newEventModel.folders = []
                                for folderJson in foldersJson {
                                    let newEventFolderModel: EventFolderModel = transaction.create(Into(EventFolderModel))
                                    newEventFolderModel.populate(folderJson)
                                    
                                    if let photosJson = folderJson["photos"].array {
                                        newEventFolderModel.photos = []
                                        for photoJson in photosJson {
                                            let newEventPhotoModel: EventPhotoModel = transaction.create(Into(EventPhotoModel))
                                            newEventPhotoModel.populate(photoJson)
                                            newEventFolderModel.photos!.insert(newEventPhotoModel)
                                        }
                                    }
                                    newEventModel.folders!.insert(newEventFolderModel)
                                }
                            }
                            events.append(newEventModel)
                        }
                    }
                    
                    return events
                }
                newMyEvents = addEventsToTransaction(eventsJson: myEventsJson)
                newContributedEvents = addEventsToTransaction(eventsJson: contributedEventsJson)
                user.myEvents = Set(newMyEvents)
                user.contributedEvents = Set(newContributedEvents)
                transaction.commitAndWait()
                
            }
        }
        return (newMyEvents, newContributedEvents)
    }

    
}
