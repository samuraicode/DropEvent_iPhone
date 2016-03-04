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
import SugarRecordCoreData

class EventsViewModel {
    
    let disposeBag = DisposeBag()
    
    var myEvents: [EventModel]
    var contributedEvents: [EventModel]
    
    var authNetworker: AuthenticatedNetworking
    
    var eventsChanged: Observable<Bool>
    
    init() {
        self.myEvents = try! DBManager.sharedInstance.db.fetch(Request<EventModel>())
        self.contributedEvents = []
        self.authNetworker = AuthenticatedNetworking()
        eventsChanged = Observable.just(false)
        if let user =  UserDBModel.fetchUser() {
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
                if let myEventsReturned = eventsReturned["Mine"].array {
                    self.myEvents = self.addEvents(myEventsReturned)
                }
                
//                if let contributedEventsReturned = eventsReturned["Contributed"].array {
//                    self.contributedEvents = self.addEvents(contributedEventsReturned)
//                }
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
    
    func addEvents(eventsJson: [JSON]) -> [EventModel] {
        var events: [EventModel] = []
        DBManager.sharedInstance.db.operation ({ (context, save) -> Void in
//            let dbEvents = try! context.fetch(Request<EventModel>())
//            try! context.remove(dbEvents)
            for eventJson in eventsJson {
                let newEventModel: EventModel = try! context.create()
                newEventModel.populate(eventJson)
                if let foldersJson = eventJson["folders"].array {
                    var folders: [EventFolderModel] = []
                    for folderJson in foldersJson {
                        let newEventFolderModel: EventFolderModel = try! context.create()
                        newEventFolderModel.populate(folderJson)
                        
                        if let photosJson = folderJson["photos"].array {
                            var photos: [EventPhotoModel] = []
                            for photoJson in photosJson {
                                let newEventPhotoModel: EventPhotoModel = try! context.create()
                                newEventPhotoModel.populate(photoJson)
                                photos.append(newEventPhotoModel)
                            }
                            newEventFolderModel.photos = NSSet(array: photos)
                        }
                        folders.append(newEventFolderModel)
                    }
                    newEventModel.folders = NSSet(array: folders)
                }
                events.append(newEventModel)
            }
            let values = try! context.request(EventModel.self).fetch()
            save()
        })
        DBManager.sharedInstance.db.operation ({ (context, save) -> Void in
            
            let values = try! context.request(EventModel.self).fetch()
        })
        let values: [EventModel] = try! DBManager.sharedInstance.db.fetch(Request<EventModel>())
        return events
    }

    
}
