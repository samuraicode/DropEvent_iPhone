//
//  SimpleEventCollectionViewCell.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/23/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import UIKit

class SimpleEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventThumbnail: UIImageView!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventModerated: UILabel!
    @IBOutlet weak var eventPhotoCount: UILabel!
    @IBOutlet weak var eventLockIcon: UIImageView!
    
    var eventTag: String!
}
