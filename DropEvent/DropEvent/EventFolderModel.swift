//
//  EventFolderModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 12/24/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import Foundation
import SwiftyJSON

class EventFolderModel {
    
    //MARK: Folder Meta Data
    var id: String
    var allowUpload: Bool
    var name: String
    
    var photos: [EventPhotoModel]
    
    
    
    //MARK: Initializers
    init(json: JSON) {
        self.id = json["id"].string ?? ""
        self.allowUpload = json["allowUpload"].bool ?? true //TODO: Default to true?
        self.name = json["name"].string ?? ""
        self.photos = []
        if let photos = json["photos"].array {
            for photoJson in photos {
                self.photos.append(EventPhotoModel(json: photoJson))
            }
        }
    }
}
