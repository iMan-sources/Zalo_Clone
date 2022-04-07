//
//  SignInView.swift
//  Zalo
//
//  Created by AnhLe on 06/04/2022.
//

import UIKit
protocol SignInViewDelegate: AnyObject {
    func enableSignInButtonInteract()
}
class SignInView: UIView {
    // MARK: - Subview
    let usernameTextfield = AuthenTextField(placeholder: "Số điện thoại")
    let passwordTextfield = AuthenTextField(placeholder: "Mật khẩu")
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    private let errorlabel = CustomLabel(content: "Fill the form", color: .systemRed, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .body))
    
    typealias textfieldValidation = (_ text: String?) -> (Bool, String)?
    
    var customValidation: textfieldValidation?
    // MARK: - Properties
    weak var delegate: SignInViewDelegate?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        setupPhoneCriteria()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //give default size, if they put into stackview, this view will know how to size itself
    //    override var intrinsicContentSize: CGSize {
    //        return CGSize(width: 200, height: 200)
    //    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
    private func updateErrorLabel(_ text: String){
        errorlabel.text = text
        stackView.addArrangedSubview(errorlabel)
    }
    
    private func setupPhoneCriteria(){
        let newPhoneCriteria: textfieldValidation = { text in
            guard let text = text, !text.isEmpty else {
                    //show error
                print("DEBUG: text is empty")
                return (false, "Nhập số điện thoại của bạn")
            }
            
            if !AuthenCriteria.nonSpecialCharacterMet(text) {
                return (false, "Tài khoản không được chứa kí tự đặc biệt")
            }
            
            if !self.userTextFieldCriteriaMet(text) {
                return(false, "Tài khoản không hợp lệ")
            }
            return (true, "")
        }
        customValidation = newPhoneCriteria
        usernameTextfield.delegate = self
    }
    
    private func userTextFieldCriteriaMet(_ text: String) -> Bool{
        switch usernameTextfield.textfield.keyboardType {
        case .default:
           
            return AuthenCriteria.nonSpecialCharacterMet(text)
        case .numberPad:
            return AuthenCriteria.isNumberAndLength(text)
        default:
            return true
        }
    }
    
    func validation(){
        if let customValidation = customValidation, let customValidationResult = customValidation(usernameTextfield.textfield.text){
            if !customValidationResult.0{
                updateErrorLabel(customValidationResult.1)
            }else{
                errorlabel.removeFromSuperview()
            }
        }
    }
    
    func resetErrorLabel(){
        errorlabel.removeFromSuperview()
    }
    
    func userTextFieldAndPasswordTextFieldIsCompleted() -> Bool{
        return !usernameTextfield.textfield.text!.isEmpty &&
        !passwordTextfield.textfield.text!.isEmpty
    }
}
// MARK: - Extension

extension SignInView {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextfield.textfield.isSecureTextEntry = true
        passwordTextfield.textfield.enablePasswordToggle()
        usernameTextfield.textfield.keyboardType = .numberPad
        usernameTextfield.textfield.enableNumberKeyboard()
        
        passwordTextfield.delegate = self
        
    }
    
    private func layout(){
        addSubview(stackView)
        stackView.addArrangedSubview(usernameTextfield)
        stackView.addArrangedSubview(passwordTextfield)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension SignInView: AuthenTextFieldDelgate {
    func didTextFieldChanged(_ sender: AuthenTextField) {
        resetErrorLabel()
        delegate?.enableSignInButtonInteract()
        
    }
    
    func didTextFieldEndEditing(_ sender: AuthenTextField) {
        delegate?.enableSignInButtonInteract()
    }
}


