//
//  ViewController.swift
//  RxDemo
//
//  Created by mac on 2021/9/28.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameLab: UILabel!
    
    @IBOutlet weak var loginLab: UILabel!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    let disposeBag = DisposeBag.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let userNameValid = nameTextField.rx.text.orEmpty
            .map{$0.count >= minimalUsernameLength}
            .share(replay: 1)
        
        let pwdValid = pwdTextField.rx.text.orEmpty
            .map{$0.count >= minimalPasswordLength}
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(userNameValid,pwdValid){$0 && $1}
            .share(replay: 1)
        
        userNameValid
            .bind(to: loginLab.rx.isEnabled)
            .disposed(by: disposeBag)
        
        userNameValid
            .bind(to: userNameLab.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        
        pwdValid
            .bind(to: pwdTextField.rx.isHidden)
            .disposed(by: disposeBag)

    }


    
}


