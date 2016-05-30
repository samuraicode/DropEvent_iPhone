//
//  SingleEventViewModel.swift
//  DropEvent
//
//  Created by Jeremy Noonan on 5/25/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import RxSwift
import RxMoya
import SwiftyJSON
import CoreStore


class SingleEventViewModel  {
    
    let disposeBag = DisposeBag()
    
    var dropevent: EventModel
    
    var dropEventProvider: RxMoyaProvider<DropEvent>
    
    let loadedEvent = Notification<(Bool)>()
    
    var folders : [EventFolderModel]
    
    var photoArrays : [[EventPhotoModel]]

    init() {
        dropEventProvider = RxMoyaProvider(endpointClosure: endpointClosure, plugins: [])
        
        dropevent = NSEntityDescription.insertNewObjectForEntityForName("EventModel", inManagedObjectContext: CoreDataStack.sharedInstance.mainObjectContext) as! EventModel
        
        folders = []
        
        photoArrays = []
    }
    
    func getEvent(lowerTag: String) -> Void {
        dropEventProvider.request(.GetByTag(tag: lowerTag)) { response in
            let response = response.value
            switch response!.statusCode {
                case 200:
                    let eventJson = JSON(data: response!.data)
                    self.dropevent.populate(eventJson)
                    if let foldersJson = eventJson["folders"].array {
                        self.dropevent.folders = []
                        for folderJson in foldersJson {
                            let newEventFolderModel = NSEntityDescription.insertNewObjectForEntityForName("EventFolderModel", inManagedObjectContext: CoreDataStack.sharedInstance.mainObjectContext) as! EventFolderModel
                            newEventFolderModel.populate(folderJson)
                            var photoArray: [EventPhotoModel] = []
                            if let photosJson = folderJson["photos"].array {
                                newEventFolderModel.photos = []
                                for photoJson in photosJson {
                                    let newEventPhotoModel = NSEntityDescription.insertNewObjectForEntityForName("EventPhotoModel", inManagedObjectContext: CoreDataStack.sharedInstance.mainObjectContext) as! EventPhotoModel
                                    newEventPhotoModel.populate(photoJson)
                                    newEventFolderModel.photos!.insert(newEventPhotoModel)
                                    photoArray.append(newEventPhotoModel)
                                }
                            }
                            self.dropevent.folders!.insert(newEventFolderModel)
                            if newEventFolderModel.photos?.count > 0 {
                                self.folders.append(newEventFolderModel)
                                self.photoArrays.append(photoArray)
                            }
                        }
                    }
                    self.loadedEvent.raise(true)
                default:
                    print("Failed to get event")
                    self.loadedEvent.raise(false)
                }
        }
    }
    
    func numberOfSections() -> Int {
        return self.folders.count
    }
    
    func labelForSection(section: Int) -> (name: String, count: Int) {
        return (self.folders[section].name, self.folders[section].photos!.count)
    }
    
    func photosForSection(section: Int) -> Int {
        return self.folders[section].photos!.count
    }
    
    func photoForSectionAndIndex(section: Int, index: Int) -> EventPhotoModel? {
        let photos = self.photoArrays[section]
        return photos[index]
    }
    
}
