//
//  CreateAccountViewController.swift
//  Zalo
//
//  Created by AnhLe on 07/04/2022.
//
import UIKit

class CreateAccountViewController: UIViewController {
    // MARK: - Subview
    private let label = CustomLabel(content: "Tên Zalo", color: .black, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .title3))
    let nameTextField = AuthenTextField(placeholder: "Gồm 2-40 kí tự")
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    // MARK: - Selector
    @objc func backButtonTapped(_ sender: UIButton){
        //back to onBoardingVc
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - API
    
    // MARK: - Helper
    private func configureNavBar(){
        self.navigationController?.navigationBar.barTintColor = .blueZalo
        self.navigationController?.navigationBar.barStyle = .black
        self.title = "Tạo tài khoản"
        let leftBarItem = UIBarButtonItem(image: Image.chevronLeft, style: .plain, target: self, action: #selector(backButtonTapped(_:)))
        self.navigationItem.leftBarButtonItems = [leftBarItem]
    }
}
// MARK: - Extension
extension CreateAccountViewController {
    
    func style(){
        view.backgroundColor = .white
        
        label.text = "Tên Zalo"
    }
    func layout(){
        view.addSubview(label)
        view.addSubview(nameTextField)
        //label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        
        ])
        
        //textfield
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalToSystemSpacingBelow: label.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
            nameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nameTextField.trailingAnchor, multiplier: 2)
        
        ])
    }
}
