//
//  PasswordViewController.swift
//  Zalo
//
//  Created by AnhLe on 13/04/2022.
//

import UIKit

class CreatePasswordViewController: SignupViewController {
    // MARK: - Subview
    let grayDescriptionView = GrayDescriptionBarView(content: "Nhập mật khẩu của bạn để tạo tài khoản mới")

    private let confirmPasswordTextField = NameTextField(placeholder: "Nhập lại mật khẩu")
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let errorLabel: UILabel = CustomLabel(content: "Mật khẩu không khớp", color: .systemRed, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .body))
    
    // MARK: - Properties
    var errorLabelHeightAnchor: NSLayoutConstraint!
    
    var isCriteriaValid: Bool = false
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupDissmissKeyboard()
//        setDoneOnKeyboard()
        configFooterAndToolBar()
        configureNavBar()
        setBothDoneOnKeyboard()
        
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
    private func configNextButton(){
        footerView.nextButton.backgroundColor = isCriteriaValid ? .blueZalo : .lightBlueGrayZalo
        footerView.nextButton.isUserInteractionEnabled = isCriteriaValid ? true : false
        toolbarView.nextButton.backgroundColor = footerView.nextButton.backgroundColor
        toolbarView.nextButton.isUserInteractionEnabled = footerView.nextButton.isUserInteractionEnabled
    }
    
    func setBothDoneOnKeyboard(){
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 60))
        let barView = UIBarButtonItem(customView: toolbarView)
        keyboardToolBar.items = [barView]
        textField.textfield.inputAccessoryView = keyboardToolBar
        confirmPasswordTextField.textfield.inputAccessoryView = keyboardToolBar
    }
    
    private func animateErrorLabel(){
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            self.errorLabelHeightAnchor.constant = self.isCriteriaValid ? 0 : 22
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func didNextButtonTapped() {
        if isCriteriaValid {
            
            animateErrorLabel()
        }else{
            animateErrorLabel()
        }
    }
}
// MARK: - Extension
extension CreatePasswordViewController {
    func style(){
        view.backgroundColor = .systemBackground
        textField = NameTextField(placeholder: "Mật khẩu")
        
        textField.delegate = self
        textField.textfield.isSecureTextEntry = true
        
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.textfield.isSecureTextEntry = true
        
    }
    
    func layout(){
        view.addSubview(grayDescriptionView)
        view.addSubview(stackView)
        view.addSubview(errorLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        
        //gray description bar
        NSLayoutConstraint.activate([
            grayDescriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            grayDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            grayDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: grayDescriptionView.bottomAnchor, multiplier: 4),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter:  stackView.trailingAnchor, multiplier: 2)
        ])
        
        errorLabelHeightAnchor = errorLabel.heightAnchor.constraint(equalToConstant: 0)
        //error label
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            errorLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            errorLabelHeightAnchor
            
        ])
    }
}

extension CreatePasswordViewController: AuthenTextFieldDelgate {
    func didTextFieldEndEditing(_ sender: AuthenTextField) {
        if sender === textField{
//            animateErrorLabel()
        }else if sender === confirmPasswordTextField{
            configNextButton()
            animateErrorLabel()
        }
//        configNextButton()
//        animateErrorLabel()

        
    }
    
    func didTextFieldChanged(_ sender: AuthenTextField) {
        if sender === textField{

        }else if sender === confirmPasswordTextField{
            if let text = sender.textfield.text{
                footerView.nextButton.backgroundColor = !text.isEmpty ? .blueZalo : .lightBlueGrayZalo
                footerView.nextButton.isUserInteractionEnabled = !text.isEmpty ? true : false
                toolbarView.nextButton.backgroundColor = footerView.nextButton.backgroundColor
                toolbarView.nextButton.isUserInteractionEnabled = footerView.nextButton.isUserInteractionEnabled
            }

        }
        isCriteriaValid = textField.textfield.text == confirmPasswordTextField.textfield.text ? true : false
//        configNextButton()
    }
    
    
}
