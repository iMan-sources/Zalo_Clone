//
//  NameTextField.swift
//  Zalo
//
//  Created by AnhLe on 08/04/2022.
//

import UIKit
// MARK: - typealias


class NameTextField: AuthenTextField {
    // MARK: - Subview
    typealias CustomValidation = (_ text: String?) -> (Bool, String)?
    // MARK: - Properties
//    var text: String?{
//        get{return textfield.text}
//        set{textfield.text = newValue}
//    }
    
    var customValidation: CustomValidation?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //give default size, if they put into stackview, this view will know how to size itsel
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
}
// MARK: - Extension
extension NameTextField {
    func validation() -> Bool{
        if let customValidation = customValidation, let customValidationResult = customValidation(text){
            if customValidationResult.0  == false{
                return false
            }
        }
        return true
    }
}
