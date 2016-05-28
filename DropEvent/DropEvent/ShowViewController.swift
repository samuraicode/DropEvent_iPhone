//
//  ShowViewController.swift
//  DropEvent
//
//  Created by Jeremy Noonan on 5/27/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

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

private let simplePhotoReuseIdentifier = "BigPhotoCellIdentifier"

class ShowViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var viewModel: SingleEventViewModel!
    var cellWidth: Int = 100
    var cellHeight: Int = 100
    // variable keep track that view appear or not.
    // we have to load collection view after view appear so correct cell size achieved.
    var isViewAppear: Bool = false
    
    @IBOutlet var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        // set view as appear
        self.isViewAppear = true
        
        // Calculate cell width, height based on screen width
        self.calculateCellWidthHeight()
        self.photoCollectionView.reloadData()
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
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isViewAppear {
            return self.viewModel.photosForSection(section)
        } else {
            return 0
        }
    }
    
    // return width and height of cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.cellWidth, height: self.cellHeight)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(simplePhotoReuseIdentifier, forIndexPath: indexPath) as! ShowPhotoCell
        if let photo = self.viewModel.photoForSectionAndIndex(indexPath.section, index: indexPath.item) {
            cell.photoDisplay.kf_setImageWithURL(photo.displayURL)
        }
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    // MARK: - Utility functions
    
    // calculate collection view cell width same as full screen
    private func calculateCellWidthHeight() {
        
        // find cell width same as screen width
        self.cellWidth = Int(self.photoCollectionView.frame.width)
        
        // find cell height
        self.cellHeight = Int(self.photoCollectionView.frame.height) - 64  // deduct nav bar and status bar height
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

