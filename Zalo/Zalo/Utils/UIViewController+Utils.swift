//
//  UIViewController+Utils.swift
//  Zalo
//
//  Created by AnhLe on 06/04/2022.
//

import UIKit

extension UIViewController {
    func setupDissmissKeyboard(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(resignResponder(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func resignResponder(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
}
