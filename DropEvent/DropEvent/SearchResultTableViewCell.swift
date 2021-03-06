//
//  SearchResultTableViewCell.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/8/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventThumbnail: UIImageView!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventModerated: UILabel!
    @IBOutlet weak var eventPhotoCount: UILabel!
    
    var eventTag: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
