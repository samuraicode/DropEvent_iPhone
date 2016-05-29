//
//  GalleryViewController.swift
//  DropEvent
//
//  Created by Jeremy Noonan on 5/25/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

private let simpleEventReuseIdentifier = "PhotoCellIdentifier"
private let sectionHeaderReuseIdentifier = "SectionHeaderIdentifier"

class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let viewModel = SingleEventViewModel()
    var eventTag = "sample"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getEvent(eventTag)
        viewModel.loadedEvent.addHandler(self, handler: GalleryViewController.handleLoaded)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
    }
    
    func handleLoaded(result: (Bool)) {
        print("Success: \(result)")
        self.collectionView?.reloadData()
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
        if segue.destinationViewController is ShowViewController {
            let showController = segue.destinationViewController as! ShowViewController
            showController.viewModel = viewModel
            showController.photoIndex = (sender as! GalleryPhotoCell).sectionIndex
        }
     }

    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.photosForSection(section)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(simpleEventReuseIdentifier, forIndexPath: indexPath) as! GalleryPhotoCell
        if let photo = self.viewModel.photoForSectionAndIndex(indexPath.section, index: indexPath.item) {
            cell.photoThumbnail.kf_setImageWithURL(photo.thumbnailURL)
        }
        cell.sectionIndex = indexPath.item
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: sectionHeaderReuseIdentifier, forIndexPath: indexPath) as! SectionHeaderView
        let headerLabel = self.viewModel.labelForSection(indexPath.section)
        header.sectionName.text = headerLabel.name
        var descriptor = "photos"
        if (headerLabel.count == 1) {
            descriptor = "photo"
        }
        header.sectionCount.text = "\(headerLabel.count) \(descriptor)"
        return header
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let headerName = self.viewModel.labelForSection(section).name
//        if headerName == "" {
//            return CGSize(width: collectionView.bounds.width, height: 10)
//        }
        return CGSize(width: collectionView.bounds.width, height: 50)
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
