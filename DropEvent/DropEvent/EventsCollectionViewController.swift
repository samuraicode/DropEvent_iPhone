//
//  EventsCollectionViewController.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/8/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

private let simpleEventReuseIdentifier = "SimpleEventIdentifier"

class EventsCollectionViewController: UICollectionViewController {
    
    let viewModel = EventsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.viewModel.eventsChanged.subscribeNext { reloadView in
            if reloadView {
                self.collectionView?.reloadData()
            }
        }.addDisposableTo(self.viewModel.disposeBag)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.viewModel.numberOfSections
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.viewModel.numberOfRows(forSection: section)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(simpleEventReuseIdentifier, forIndexPath: indexPath) as! SimpleEventCollectionViewCell
        let event = self.viewModel.event(forIndexPath: indexPath)
        cell.eventName.text = event.name
        if let eventThumbnailURL = event.thumbnailURL {
          cell.eventThumbnail.kf_setImageWithURL(eventThumbnailURL)
        }
        cell.backgroundColor = UIColor.blueColor()
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
