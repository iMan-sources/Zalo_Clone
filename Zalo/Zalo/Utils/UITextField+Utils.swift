//
//  UITextField+Utils.swift
//  Zalo
//
//  Created by AnhLe on 06/04/2022.
//

import UIKit
let passwordToggleButton = UIButton(type: .custom)
let userToggleButton = UIButton(type: .custom)
extension UITextField {
    func enablePasswordToggle(){
        passwordToggleButton.setTitle("HIỆN", for: .normal)
        passwordToggleButton.setTitleColor(.darkGray, for: .normal)
        passwordToggleButton.setTitle("ẨN", for: .selected)
        passwordToggleButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        passwordToggleButton.adjustsImageWhenHighlighted = false
        rightView = passwordToggleButton
        passwordToggleButton.addTarget(self, action: #selector(togglePassword(_:)), for: .touchUpInside)
        rightViewMode = .always
    }
    
    @objc func togglePassword(_ sender: UIButton){
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
        self.layoutIfNeeded()
    }
    
    func enableNumberKeyboard(){
        userToggleButton.setImage(Image.alphabet.withTintColor(UIColor.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        userToggleButton.setImage(Image.numberRectangle.withTintColor(UIColor.darkGray, renderingMode: .alwaysOriginal), for: .selected)
        
        userToggleButton.adjustsImageWhenHighlighted = false
        userToggleButton.addTarget(self, action: #selector(toggleUserTf(_:)), for: .touchUpInside)
        
        rightView = userToggleButton
        rightViewMode = .always
        
        
    }
    @objc func toggleUserTf(_ sender: UIButton){
        userToggleButton.isSelected.toggle()
        keyboardType = userToggleButton.isSelected ? .default : .numberPad
        placeholder = userToggleButton.isSelected ? "Username" : "Số điện thoại"
        self.reloadInputViews()
    }
    
    
}
