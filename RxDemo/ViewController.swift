//
//  ViewController.swift
//  RxDemo
//
//  Created by mac on 2021/9/28.
//

import UIKit
import RxSwift
import RxCocoa

let maxCount = 10

class ViewController: UIViewController {

    let disposeBag = DisposeBag.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lab = UILabel.init(frame: .init(x:(view.frame.width - 100)/2, y: 50, width: 100, height: 30))
        lab.textColor = .black
        view.addSubview(lab)
        
        let textfiled = UITextField.init(frame: .init(x: 0, y: 0, width: 200, height: 40))
        textfiled.center = view.center
        textfiled.textColor = .black
        textfiled.backgroundColor = .red
        textfiled.borderStyle = .roundedRect
        textfiled.rx.text.orEmpty.asObservable()
            .subscribe(onNext:{
                print("text1 = \($0)  count1 = \($0.count)")
                let count = $0.count
                if count > maxCount{
                    let index = $0.index($0.startIndex, offsetBy: maxCount)
                    let text = $0.substring(to: index)
                    textfiled.text = text
                    print("text2 = \(text)  count2 = \(text.count)")
                }
            })
            .disposed(by: disposeBag)
        
        ///绑定到其他view上
        textfiled.rx.text.bind(to: lab.rx.text).disposed(by: disposeBag)        

        view.addSubview(textfiled)
        
        
        
        
    }


    
}


