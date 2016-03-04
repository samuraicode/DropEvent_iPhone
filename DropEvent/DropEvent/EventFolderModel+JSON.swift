//
//  EventFolderModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 12/24/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import SwiftyJSON

extension EventFolderModel {
    
    
    
    //MARK: populate from json
    func populate(json: JSON) {
        self.id = json["id"].string ?? ""
        self.allowUpload = json["allowUpload"].bool ?? true //TODO: Default to true?
        self.name = json["name"].string ?? ""
    }
}
