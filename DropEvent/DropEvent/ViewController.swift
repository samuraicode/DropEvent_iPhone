//
//  ViewController.swift
//  DropEvent
//
//  Created by Jeremy Noonan on 12/10/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let api = EventAPI()
        api.getEvent().subscribeNext {[weak self] event in
//            self?.image.kf_setImageWithURL(event.thumbnailURL)
            self?.image.kf_setImageWithURL(event.thumbnailURL, placeholderImage: nil, optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                
            })
            print(event.name)
        }.addDisposableTo(disposeBag)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

