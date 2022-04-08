//
//  CreateAccountViewController.swift
//  Zalo
//
//  Created by AnhLe on 07/04/2022.
//
import UIKit
// MARK: - Typealias

class CreateAccountViewController: UIViewController {
    typealias CustomValidation = NameTextField.CustomValidation
    // MARK: - Subview
    private let label = CustomLabel(content: "Tên Zalo", color: .black, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .title3))
    let nameTextField = NameTextField(placeholder: "Gồm 2-40 kí tự")
    
    private let warningSetNameLabel = CustomLabel(content: "Lưu ý khi đặt tên", color: .black, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .body))
    
    private let criteriaStatusView = NameCriteriaStatusView()
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupDissmissKeyboard()
        setupNameTextFieldCriteria()
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
        view.addSubview(warningSetNameLabel)
        view.addSubview(criteriaStatusView)
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
        
        //warningSetNameLabel
        NSLayoutConstraint.activate([
            warningSetNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameTextField.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
            warningSetNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: warningSetNameLabel.trailingAnchor, multiplier: 2)
            
        ])
        
        //criteria status view
        NSLayoutConstraint.activate([
            criteriaStatusView.topAnchor.constraint(equalToSystemSpacingBelow: warningSetNameLabel.bottomAnchor, multiplier: 1),
            criteriaStatusView.leadingAnchor.constraint(equalTo: warningSetNameLabel.leadingAnchor),
            criteriaStatusView.trailingAnchor.constraint(equalTo: warningSetNameLabel.trailingAnchor)
        
        ])
    }
}

extension CreateAccountViewController {
    func setupNameTextFieldCriteria(){
        let nameValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else{
                return (false, "enter yout password")
            }
            // criteria met
            self.criteriaStatusView.updateDisplay(text)
            
            return (true, "")
        }
        nameTextField.customValidation = nameValidation
        nameTextField.delegate = self
    }
}

extension CreateAccountViewController: AuthenTextFieldDelgate {
    func didTextFieldEndEditing(_ sender: AuthenTextField) {
        if sender === nameTextField {
            // not reset to cirle image
            print("DEBUG: name tf end editing")
            criteriaStatusView.shouldResetCriteria = false
            _ = nameTextField.validation()
        }
    }
    
    func didTextFieldChanged(_ sender: AuthenTextField) {
        if sender === nameTextField {
            criteriaStatusView.updateDisplay(sender.textfield.text ?? "")
        }
    }
    
    
}
