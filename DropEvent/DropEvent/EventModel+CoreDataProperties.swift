//
//  EventModel+CoreDataProperties.swift
//  DropEvent
//
//  Created by Jesse Gatt on 3/16/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension EventModel {

    @NSManaged var allowDownload: NSNumber
    @NSManaged var contributorCount: NSNumber
    @NSManaged var created: NSDate
    @NSManaged var directory: String
    @NSManaged var email: String
    @NSManaged var eventDescription: String
    @NSManaged var expiration: NSDate
    @NSManaged var expirationText: String
    @NSManaged var expired: NSNumber
    @NSManaged var id: String
    @NSManaged var isCollection: NSNumber
    @NSManaged var isModerated: NSNumber
    @NSManaged var isOpen: NSNumber
    @NSManaged var isOwner: NSNumber
    @NSManaged var isPublic: NSNumber
    @NSManaged var name: String
    @NSManaged var nameLower: String
    @NSManaged var owner: String
    @NSManaged var password: String
    @NSManaged var pendingCount: NSNumber
    @NSManaged var photoCount: NSNumber
    @NSManaged var premium: NSNumber
    @NSManaged var reminded: NSNumber
    @NSManaged var reminderCount: NSNumber
    @NSManaged var showAd: NSNumber
    @NSManaged var showFileName: NSNumber
    @NSManaged var sortBy: NSNumber
    @NSManaged var tag: String
    @NSManaged var tagLower: String
    @NSManaged var thumbnailURLString: String
    @NSManaged var unsorted: String
    @NSManaged var userFolder: NSNumber
    @NSManaged var varySizes: NSNumber
    @NSManaged var folders: Set<EventFolderModel>?

}
