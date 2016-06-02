//
//  SearchEventsTableViewController.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/8/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchEventsTableViewController: UITableViewController {
    
    let viewModel = SearchEventsViewModel()
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.rx_text.throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { newSearch -> Observable<Bool> in
                if newSearch.isEmpty {
                    return Observable.just(false)
                }
                return self.viewModel.findEvents(newSearch.lowercaseString).map({ foundResult in
                    return foundResult
                }).startWith(false)
            
        }.switchLatest()
        .subscribeNext { success in
            if success {
                self.tableView.reloadData()
            }
        }.addDisposableTo(self.viewModel.disposeBag)

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
            (segue.destinationViewController as! GalleryViewController).eventTag = (sender as! SearchResultTableViewCell).eventTag
            segue.destinationViewController.navigationItem.title = (sender as! SearchResultTableViewCell).eventName.text
        }
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.numberOfTableRows()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell", forIndexPath: indexPath) as! SearchResultTableViewCell
        let event = self.viewModel.eventFor(indexPath)
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}

