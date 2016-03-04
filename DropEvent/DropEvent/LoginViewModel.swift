//
//  LoginViewModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 1/13/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import RxSwift
import RxMoya
import SwiftyJSON
import SugarRecordCoreData

class LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    var email = Variable<String>("")
    var password = Variable<String>("")
    
    let loginTaps = PublishSubject<Void>()
    
    let validatedEmail: Observable<Bool>
    let validatedPassword: Observable<Bool>
    
    // Is signup button enabled
    let enableLogin: Observable<Bool>
    
    
    init() {
        
        validatedEmail = email.asObservable().map { email in
            return LoginValidationService.validEmail(email)
        }.shareReplay(1)
        
        validatedPassword = password.asObservable().map { password in
            return LoginValidationService.validPassword(password)
        }.shareReplay(1)
        
        enableLogin = Observable.combineLatest(validatedEmail, validatedPassword, resultSelector: { validEmail, validPassword in
            return validEmail && validPassword
        }).startWith(false)
        .shareReplay(1)
    }
    
    func getSignedIn() -> Observable<Bool> {
        let networker = LoginNetworking()
        let usernameAndPassword = Observable.combineLatest(email.asObservable(), password.asObservable()) { ($0, $1) }
        
        return loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { (email, password) in
                return Observable.combineLatest(networker.provider.request(.Login(email: email, password: password)), Observable.just(email)) { ($0, $1) }
            }
            .map({ response, email in
                switch response.statusCode {
                case 200:
                    let json = JSON(data: response.data)
                    DBManager.sharedInstance.db.operation({ (context, save) -> Void in
                        let newUser: UserDBModel = try! context.create()
                        newUser.email = email
                        newUser.sessionToken = json["token"].string ?? ""
                        save()
                    })
                    return true
                default:
                    return false
                }
            }).observeOn(MainScheduler.instance)
    }
    
    
}



class LoginValidationService {
    
    
    class func validEmail(email: String) -> Bool {
        if email.isEmpty {
            return false
        }
        
        
        return true
    }
    
    class func validPassword(password: String) -> Bool {
        if password.isEmpty {
            return false
        }
        
        
        return true
    }
}