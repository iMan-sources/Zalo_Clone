//
//  SignupViewController.swift
//  Zalo
//
//  Created by AnhLe on 09/04/2022.
//

import UIKit

class SignupViewController: UIViewController, FooterViewDelegate {
    // MARK: - Subview
    var textField: NameTextField!
    let footerView = FooterView()
    let toolbarView = FooterView()
    // MARK: - Properties
    
    // MARK: - Lifecycle    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        footerView.delegate = self
        toolbarView.delegate = self
        setupFooterView()
        configureNavBar()
    }

    // MARK: - Selector
    @objc func backButtonTapped(_ sender: UIButton){
        //back to onBoardingVc
        self.navigationController?.popViewController(animated: true)
    }
    
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
    
    func configureNavBar(){
        self.navigationController?.navigationBar.barTintColor = .blueZalo
        self.navigationController?.navigationBar.barStyle = .black
        self.title = "Tạo tài khoản"
        let leftBarItem = UIBarButtonItem(image: Image.chevronLeft, style: .plain, target: self, action: #selector(backButtonTapped(_:)))
        self.navigationItem.leftBarButtonItems = [leftBarItem]
    }
    
    //to override
    func didNextButtonTapped() {}
}


