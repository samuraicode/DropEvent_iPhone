//
//  EventPhotoModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 12/24/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import Foundation
import SwiftyJSON


class EventPhotoModel {
    
    var hdid: String
    var id: String
    
    var eventID: String
    var eventOwner: String
    
    var folderID: String
    
    var email: String
    
    var displayURL: NSURL
    var processedURL: NSURL
    var thumbNailURL: NSURL
    var taken: NSDate
    var uploaded: NSDate
    var caption: String
    
    //MARK: Initializers
    init(json: JSON) {
        self.hdid = json["HDID"].string ?? ""
        self.id = json["_id"].string ?? ""
        self.eventID = json["eventId"].string ?? ""
        self.eventOwner = json["eventOwner"].string ?? ""
        self.folderID = json["folderId"].string ?? ""
        
        self.email = json["email"].string ?? ""
        
        self.displayURL = NSURL(string: json["display"].string ?? "")!
        self.processedURL = NSURL(string: json["processed"].string ?? "")!
        self.thumbNailURL = NSURL(string: json["thumbnail"].string ?? "")!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.taken = dateFormatter.dateFromString(json["taken"].string ?? "") ?? NSDate()
        self.uploaded = dateFormatter.dateFromString(json["uploaded"].string ?? "") ?? NSDate()
        self.caption = json["caption"].string ?? ""
        
    }
    
    
}