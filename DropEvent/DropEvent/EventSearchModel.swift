//
//  EventSearchModel.swift
//  DropEvent
//
//  Created by Jeremy Noonan on 5/25/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation

import SwiftyJSON

class EventSearchModel {
    
    var allowDownload: NSNumber
    var contributorCount: NSNumber
    var created: NSDate
    var directory: String
    var email: String
    var eventDescription: String
    var expiration: NSDate
    var expirationText: String
    var expired: NSNumber
    var id: String
    var isCollection: NSNumber
    var isModerated: NSNumber
    var isOpen: NSNumber
    var isOwner: NSNumber
    var isPublic: NSNumber
    var name: String
    var nameLower: String
    var owner: String
    var password: String
    var pendingCount: NSNumber
    var photoCount: NSNumber
    var premium: NSNumber
    var reminded: NSNumber
    var reminderCount: NSNumber
    var showAd: NSNumber
    var showFileName: NSNumber
    var sortBy: NSNumber
    var tag: String
    var tagLower: String
    var thumbnailURLString: String
    var unsorted: String
    var userFolder: NSNumber
    var varySizes: NSNumber
    var folders: Set<EventFolderModel>?
    
    var thumbnailURL: NSURL? {
        get {
            return NSURL(string: self.thumbnailURLString)
        }
    }
    
    //MARK: Initializers
    init(json: JSON) {
        self.id = json["id"].string ?? ""
        self.owner = json["owner"].string ?? ""
        self.isOpen = NSNumber(bool: json["isOpen"].bool ?? true)
        self.isCollection = NSNumber(bool: json["isCollection"].bool ?? false)
        self.unsorted = json["unsorted"].string ?? ""
        self.sortBy = SortType(string: json["sortBy"].string ?? "").rawValue
        self.password = json["password"].string ?? ""
        self.directory = json["directory"].string ?? ""
        self.varySizes = NSNumber(bool: json["varySizes"].bool ?? false)
        self.contributorCount = json["contribCount"].int ?? 1
        //TODO:Fix data formatter
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss4Z"
        
        self.expiration = dateFormatter.dateFromString(json["expiration"].string ?? "") ?? NSDate()
        self.expirationText = json["expires"].string ?? ""
        self.reminderCount = json["reminderCount"].int ?? 0
        self.pendingCount = json["pendingCount"].int ?? 0
        self.photoCount = json["photoCount"].int ?? 0
        self.expired = NSNumber(bool: json["expired"].bool ?? false)
        self.allowDownload = NSNumber(bool: json["allowDownload"].bool ?? true)
        self.reminded = NSNumber(bool: json["reminded"].bool ?? true)
        self.premium = json["premium"].int ?? 0
        self.showFileName = NSNumber(bool: json["showFilename"].bool ?? false)
        self.userFolder = NSNumber(bool: json["userFolder"].bool ?? true)
        self.isPublic = NSNumber(bool: json["isPublic"].bool ?? true)
        self.isModerated = NSNumber(bool: json["isModerated"].bool ?? false)
        self.isOwner = NSNumber(bool: json["isOwner"].bool ?? false)
        self.showAd = NSNumber(bool: json["showAd"].bool ?? false)
        
        self.name = json["name"].string ?? ""
        self.nameLower = json["lowerName"].string ?? ""
        self.tag = json["tag"].string ?? ""
        self.tagLower = json["lowerTag"].string ?? ""
        self.created = dateFormatter.dateFromString(json["created"].string ?? "") ?? NSDate()
        self.thumbnailURLString = json["thumbnail"].string ?? ""
        self.eventDescription = json["description"].string ?? ""
        self.email = json["email"].string ?? ""
        
    }
}
