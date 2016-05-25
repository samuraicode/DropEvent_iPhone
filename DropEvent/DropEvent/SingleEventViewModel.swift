//
//  SingleEventViewModel.swift
//  DropEvent
//
//  Created by Jeremy Noonan on 5/25/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import RxSwift
import RxMoya
import SwiftyJSON


class SingleEventViewModel  {
    
    let disposeBag = DisposeBag()
    
    var dropevent: EventModel
    
    var dropEventProvider: RxMoyaProvider<DropEvent>

    init() {
        dropEventProvider = RxMoyaProvider(endpointClosure: endpointClosure, plugins: [])
        dropevent = EventModel()
        
    }
    
    func getEvent(lowerTag: String) -> Observable<Bool> {
        return dropEventProvider.request(.GetByTag(tag: lowerTag)).observeOn(MainScheduler.instance).map({ response in
            switch response.statusCode {
            case 200:
                self.dropevent = EventModel()
                self.dropevent.populate(JSON(data: response.data))
                return true
            default:
                return false
            }
        })
    }
    
    func numberOfSections() -> Int {
        return self.dropevent.folders!.count
    }
    
    func photosForSection(section: Int) -> Int {
        return 10
        //return self.dropevent.folders![section].photos.count
    }
    
}
