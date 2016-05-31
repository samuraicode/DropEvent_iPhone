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

class EventsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let viewModel = EventsViewModel()
    var cellWidth: Int = 100
    var cellHeight: Int = 160
    // variable keep track that view appear or not.
    // we have to load collection view after view appear so correct cell size achieved.
    var isViewAppear: Bool = false
    
    @IBOutlet var eventCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.viewModel.eventsChanged.subscribeNext { reloadView in
            if reloadView {
                self.eventCollectionView.reloadData()
            }
        }.addDisposableTo(self.viewModel.disposeBag)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        // set view as appear
        self.isViewAppear = true
        
        // Calculate cell width, height based on screen width
        self.calculateCellWidthHeight(nil)
        self.eventCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.destinationViewController is GalleryViewController {
            (segue.destinationViewController as! GalleryViewController).eventTag = (sender as! SimpleEventCollectionViewCell).eventTag
            segue.destinationViewController.navigationItem.title = (sender as! SimpleEventCollectionViewCell).eventName.text
        }
    }

    // MARK: UICollectionViewDataSource
    
    // return width and height of cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.cellWidth, height: self.cellHeight)
    }

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
        cell.eventDescription.text = event.eventDescription
        if event.isModerated.boolValue {
            cell.eventModerated.alpha = 1.0
        } else {
            cell.eventModerated.alpha = 0
        }
        if event.photoCount == 1 {
            cell.eventPhotoCount.text = "\(event.photoCount) photo"
        } else {
            cell.eventPhotoCount.text = "\(event.photoCount) photos"
        }
        cell.eventTag = event.tagLower
        if let eventThumbnailURL = event.thumbnailURL {
          cell.eventThumbnail.kf_setImageWithURL(eventThumbnailURL)
        }
        
        // Rounded corners
        cell.eventThumbnail.layer.cornerRadius = cell.eventThumbnail.frame.size.width / 8
        cell.eventThumbnail.clipsToBounds = true
    
        return cell
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.calculateCellWidthHeight(size)
        
        self.eventCollectionView.alpha = CGFloat.init(0)
        self.eventCollectionView.performBatchUpdates(nil, completion: { (Bool) -> Void in
            self.eventCollectionView.alpha = CGFloat.init(1)
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    // MARK: - Utility functions
    
    // calculate collection view cell width same as full screen
    private func calculateCellWidthHeight(size: CGSize!) {
        if size == nil {
            // find cell width same as screen width
            self.cellWidth = Int(self.eventCollectionView.frame.width)
        } else {
            self.cellWidth = Int(size.width)
        }
        
        self.cellWidth -= 10
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
