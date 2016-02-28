//
//  LoginViewController.swift
//  DropEvent
//
//  Created by Jesse Gatt on 1/13/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.becomeFirstResponder()
        
        emailField.rx_text.distinctUntilChanged()
        .bindTo(self.viewModel.email).addDisposableTo(self.viewModel.disposeBag)
        
        passwordField.rx_text.distinctUntilChanged()
        .bindTo(self.viewModel.password).addDisposableTo(self.viewModel.disposeBag)
        
        self.viewModel.enableLogin.subscribeNext { canLogin in
            if canLogin {
                self.loginButton.enabled = true
            }else {
                self.loginButton.enabled = false
            }
        }.addDisposableTo(self.viewModel.disposeBag)
        
        loginButton.rx_tap.bindTo(self.viewModel.loginTaps).addDisposableTo(self.viewModel.disposeBag)
        
        viewModel.getSignedIn().subscribeNext { loggedIn in
            if loggedIn {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.setEventsAsRoot()
            }
            
        }.addDisposableTo(self.viewModel.disposeBag)
    }

}
