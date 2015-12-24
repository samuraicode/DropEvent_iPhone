//
//  ViewController.swift
//  DropEvent
//
//  Created by Jeremy Noonan on 12/10/15.
//  Copyright © 2015 SamuraiCode. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let api = EventAPI()
        api.getEvent().subscribeNext { event in
            print(event.name)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

