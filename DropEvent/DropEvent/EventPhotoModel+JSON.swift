//
//  EventPhotoModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 12/24/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import SwiftyJSON


extension EventPhotoModel {
    
    var displayURL: NSURL {
        get {
            return NSURL(string: self.displayURLString)!
        }
    }
    
    //MARK: Initializers
    func populate(json: JSON) {
        self.id = json["_id"].string ?? ""
        self.eventID = json["eventId"].string ?? ""
        self.eventOwner = json["eventOwner"].string ?? ""
        self.folderID = json["folderId"].string ?? ""
        
        self.email = json["email"].string ?? ""
        
        self.displayURLString = json["display"].string ?? ""
        self.processedURLString = json["processed"].string ?? ""
        self.thumbNailURLString = json["thumbnail"].string ?? ""
        let dateFormatter = NSDateFormatter()
        //TODO: Fix formatter
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.taken = dateFormatter.dateFromString(json["taken"].string ?? "") ?? NSDate()
        self.uploaded = dateFormatter.dateFromString(json["uploaded"].string ?? "") ?? NSDate()
        self.caption = json["caption"].string ?? ""
        
    }
    
    
}