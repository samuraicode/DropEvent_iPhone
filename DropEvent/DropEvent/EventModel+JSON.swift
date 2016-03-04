//
//  EventModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 12/24/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import SwiftyJSON

enum SortType: Int {
    case uploaded = 1 //"uploaded"
    case dateTaken = 2 //"datetaken"
    case filename = 3 //"filename"
    case none = 0 //""
    
    init(string: String) {
        switch string {
            case "uploaded":
                self = uploaded
            case "datetaken":
                self = dateTaken
            case "filename":
                self = filename
            default:
                self = none
        }
    }
    
    func stringValue() -> String {
        switch self {
        case uploaded:
            return "uploaded"
        case dateTaken:
            return "datetaken"
        case filename:
            return "filename"
        default:
            return ""
        }
    }
}

extension EventModel {
    
    //MARK: Initializers
    func populate(json: JSON) {
        self.id = json["id"].string ?? ""
        self.ownerId = json["owner"].string ?? ""
        self.isOpen = json["isOpen"].bool ?? true
        self.isCollection = json["isCollection"].bool ?? false
        self.unsorted = json["unsorted"].string ?? ""
        self.sortBy = SortType(string: json["sortBy"].string ?? "").rawValue
        self.password = json["password"].string ?? ""
        self.directory = json["directory"].string ?? ""
        self.varySizes = json["varySizes"].bool ?? false
        self.contributorCount = json["contribCount"].int ?? 1
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        self.expiration = dateFormatter.dateFromString(json["expiration"].string ?? "") ?? NSDate()
        self.expirationText = json["expires"].string ?? ""
        self.reminderCount = json["reminderCount"].int ?? 0
        self.pendingCount = json["pendingCount"].int ?? 0
        self.photoCount = json["photoCount"].int ?? 0
        self.expired = json["expired"].bool ?? false
        self.allowDownload = json["allowDownload"].bool ?? true
        self.reminded = json["reminded"].bool ?? true
        self.premium = json["premium"].int ?? 0
        self.showFileName = json["showFilename"].bool ?? false
        self.userFolder = json["userFolder"].bool ?? true
        self.isPublic = json["isPublic"].bool ?? true
        self.isModerated = json["isModerated"].bool ?? false
        self.isOwner = json["isOwner"].bool ?? false
        self.showAd = json["showAd"].bool ?? false
        
        self.name = json["name"].string ?? ""
        self.nameLower = json["lowerName"].string ?? ""
        self.tag = json["tag"].string ?? ""
        self.created = dateFormatter.dateFromString(json["created"].string ?? "") ?? NSDate()
        self.thumbnailURLString = json["thumbnail"].string ?? ""
        self.eventDescription = json["description"].string ?? ""
        self.email = json["email"].string ?? ""
        
    }
}

