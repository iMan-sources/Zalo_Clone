//
//  SignupViewController.swift
//  Zalo
//
//  Created by AnhLe on 09/04/2022.
//

import UIKit

class SignupViewController: UIViewController {
    // MARK: - Subview
    var textField: NameTextField!
    let footerView = FooterView()
    let toolbarView = FooterView()
    // MARK: - Properties
    
    // MARK: - Lifecycle    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFooterView()
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
    func setDoneOnKeyboard(){
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 60))
        let barView = UIBarButtonItem(customView: toolbarView)
        keyboardToolBar.items = [barView]
        textField.textfield.inputAccessoryView = keyboardToolBar
    }
    func setupFooterView(){
        //footerView
        view.addSubview(footerView)
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
    }
}

