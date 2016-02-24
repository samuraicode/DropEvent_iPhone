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

class LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    var email = Variable<String>("")
    var password = Variable<String>("")
    
    let loginTaps = PublishSubject<Void>()
    
    let validatedEmail: Observable<Bool>
    let validatedPassword: Observable<Bool>
    
    // Is signup button enabled
    let enableLogin: Observable<Bool>
    
    // Has user signed in
    let signedIn: Observable<Bool>
    
    let user: UserModel
    
    
    init(user: UserModel) {
        self.user = user
        
        let networker = LoginNetworking()
        
        validatedEmail = email.map { email in
            return LoginValidationService.validEmail(email)
        }.shareReplay(1)
        
        validatedPassword = password.map { password in
            return LoginValidationService.validPassword(password)
        }.shareReplay(1)
        
        enableLogin = combineLatest(validatedEmail, validatedPassword, resultSelector: { validEmail, validPassword in
            return validEmail && validPassword
        }).startWith(false)
        .shareReplay(1)
        
        
        let usernameAndPassword = combineLatest(email, password) { ($0, $1) }
        
        signedIn = loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { (email, password) in
                return combineLatest(networker.provider.request(.Login(email: email, password: password)), just(email)) { ($0, $1) }
            }
            .observeOn(MainScheduler.sharedInstance)
            .map({ response, email in
                switch response.statusCode {
                case 200:
                    let json = JSON(data: response.data)
                    user.email = email
                    user.sessionToken = json["token"].string ?? ""
//                    user.save()
                    return true
                default:
                    return false
                }
            })
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