//
//  EventModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 12/24/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import Foundation
import SwiftyJSON

enum SortType: String {
    case uploaded = "uploaded"
    case none = ""
}

class EventModel {
    
    //MARK: Event Meta Data
    var id: String
    var ownerId: String
    var beta: Bool //not sure if really need this
    var isOpen: Bool
    var isCollection: Bool
    var unsorted: String
    var sortBy: SortType
    var password: String //maybe make nsdata in future
    var directory: String
    var varySizes: Bool
    var contributorCount: Int
    
    
    //MARK: Event permissions
    var expiration: NSDate
    var expirationText: String
    var reminderCount: Int
    var pendingCount: Int
    var photoCount: Int
    var expired: Bool
    var allowDownload: Bool
    var reminded: Bool
    var premium: Int
    var showFileName: Bool
    var userFolder: Bool
    var isPublic: Bool
    var isModerated: Bool
    var isOwner: Bool
    var showAd: Bool
    
    
    //MARK: Event Info
    var name: String
    var nameLower: String
    var tag: String
    var created: NSDate
    var thumbnailURL: NSURL
    var description: String
    var email: String
    var folders: [EventFolderModel]
    
    
    
    //MARK: Initializers
    init(json: JSON) {
        self.id = json["id"].string ?? ""
        self.ownerId = json["owner"].string ?? ""
        self.beta = json["beta"].bool ?? false
        self.isOpen = json["isOpen"].bool ?? true
        self.isCollection = json["isCollection"].bool ?? false
        self.unsorted = json["unsorted"].string ?? ""
        self.sortBy = SortType(rawValue: json["sortBy"].string ?? "")!
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
        self.thumbnailURL = NSURL(string: json["thumbnail"].string ?? "")!
        self.description = json["description"].string ?? ""
        self.email = json["email"].string ?? ""
        self.folders = []
        if let folders = json["folders"].array {
            for folderJson in folders {
                self.folders.append(EventFolderModel(json: folderJson))
            }
        }
        
    }
}

