//
//  CreateAccountViewController.swift
//  Zalo
//
//  Created by AnhLe on 07/04/2022.
//
import UIKit
// MARK: - Typealias

class CreateAccountViewController: SignupViewController {
    typealias CustomValidation = NameTextField.CustomValidation
    // MARK: - Subview
    private let label = CustomLabel(content: "Tên Zalo", color: .black, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .title3))
//    var textField: NameTextField!
   
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
        setDoneOnKeyboard()
        configFooterAndToolBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        textField.resignFirstResponder()
        textField.endEditing(true)
    }
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper

    
    private func enableNextButton(){
        if !(textField.textfield.text!.isEmpty) && criteriaStatusView.isMatchAllCriteria {
            footerView.nextButton.isUserInteractionEnabled = true
            footerView.nextButton.backgroundColor = .blueZalo
            toolbarView.nextButton.backgroundColor = .blueZalo
            toolbarView.nextButton.isUserInteractionEnabled = true
        }else{
            footerView.nextButton.isUserInteractionEnabled = false
            toolbarView.nextButton.isUserInteractionEnabled = false
            footerView.nextButton.backgroundColor = .lightBlueGrayZalo
            toolbarView.nextButton.backgroundColor = .lightBlueGrayZalo
        }
    }
    
    func style() {
        label.text = "Tên Zalo"
        textField = NameTextField(placeholder: "Gồm 2-40 kí tự")
//        nameTextField = textField
        
    }

    func layout(){
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(warningSetNameLabel)
        view.addSubview(criteriaStatusView)
        
        view.addSubview(footerView)
        
        //label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        
        ])
        
        //textfield
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalToSystemSpacingBelow: label.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 2)
        
        ])
        
        //warningSetNameLabel
        NSLayoutConstraint.activate([
            warningSetNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: textField.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
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
    
    override func didNextButtonTapped() {
        // move to create phone controller
        let vc = CreatePhoneViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - Extension
extension CreateAccountViewController{
    

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
        textField.customValidation = nameValidation
        textField.delegate = self
    }
    

    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
}

extension CreateAccountViewController: AuthenTextFieldDelgate {
    func didTextFieldEndEditing(_ sender: AuthenTextField) {
        if sender === textField {
            // not reset to cirle image
            criteriaStatusView.shouldResetCriteria = false
            
            _ = textField.validation()
            
            enableNextButton()
        }
    }
    
    func didTextFieldChanged(_ sender: AuthenTextField) {
        if sender === textField {
            criteriaStatusView.updateDisplay(sender.textfield.text ?? "")
            enableNextButton()
        }
    }
}
