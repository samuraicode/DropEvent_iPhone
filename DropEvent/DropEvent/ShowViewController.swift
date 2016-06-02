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
    var photoIndex : Int = 0
    var photoPath = NSIndexPath.init(forItem: 0, inSection: 0)
    var sectionIndex : Int = 0
    var cellWidth: Int = 100
    var cellHeight: Int = 100
    // variable keep track that view appear or not.
    // we have to load collection view after view appear so correct cell size achieved.
    var isViewAppear: Bool = false
    var playMode: Bool = false
    var timer = NSTimer()
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    
    @IBOutlet var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.title = self.viewModel.dropevent.name
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        // set view as appear
        self.isViewAppear = true
        
        // Calculate cell width, height based on screen width
        self.calculateCellWidthHeight(nil)
        self.photoCollectionView.reloadData()
        
        if (self.photoIndex > 0) {
            photoPath = NSIndexPath.init(forItem: self.photoIndex, inSection: 0)
            self.photoCollectionView.scrollToItemAtIndexPath(photoPath, atScrollPosition: .CenteredHorizontally, animated: false )
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.timer.invalidate()
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
            return self.viewModel.photosForSection(sectionIndex)
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
        if let photo = self.viewModel.photoForSectionAndIndex(sectionIndex, index: indexPath.item) {
            cell.photoDisplay.kf_setImageWithURL(photo.displayURL, placeholderImage: nil, optionsInfo: [.Transition(ImageTransition.Fade(1))])
            if photo.caption != "" {
                cell.caption.text = photo.caption
                cell.caption.alpha = 1.0
            } else {
                cell.caption.alpha = 0
            }
        }
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        photoPath = getCurrentPhotoPath()
        self.calculateCellWidthHeight(size)
        self.collectionView?.alpha = CGFloat.init(0)
        self.collectionView!.performBatchUpdates(nil, completion: { (Bool) -> Void in
            self.photoCollectionView.scrollToItemAtIndexPath(self.photoPath, atScrollPosition: .CenteredHorizontally, animated: false )
            self.collectionView?.alpha = CGFloat.init(1)
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    // MARK: - Utility functions
    
    private func getCurrentPhotoPath() -> NSIndexPath {
        let visibleRect = CGRect.init(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        let visiblePoint = CGPoint.init(x: CGRectGetMidX(visibleRect), y: CGRectGetMidY(visibleRect))
        return (self.collectionView?.indexPathForItemAtPoint(visiblePoint))!
    }
    
    // calculate collection view cell width same as full screen
    private func calculateCellWidthHeight(size: CGSize!) {
        if size == nil {
            // find cell width same as screen width
            self.cellWidth = Int(self.photoCollectionView.frame.width)
            
            // find cell height
            self.cellHeight = Int(self.photoCollectionView.frame.height)
        } else {
            self.cellWidth = Int(size.width)
            self.cellHeight = Int(size.height)
        }
        
        if self.cellWidth > self.cellHeight { // deduct nav bar and status bar height
            self.cellHeight -= 32
        } else {
            self.cellHeight -= 64
        }
    }
    
    @IBAction func playPushed(sender: AnyObject) {
        if playMode {
            timer.invalidate()
        } else {
            moveSlideshow()
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target:self, selector: #selector(ShowViewController.moveSlideshow), userInfo: nil, repeats: true)
        }
        playMode = !playMode
    }
    
    func moveSlideshow() {
        photoPath = getCurrentPhotoPath()
        let nextPath = NSIndexPath.init(forItem: photoPath.item + 1, inSection: photoPath.section)
        print(nextPath.item)
        photoCollectionView.scrollToItemAtIndexPath(nextPath, atScrollPosition: .CenteredHorizontally, animated: false )
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

