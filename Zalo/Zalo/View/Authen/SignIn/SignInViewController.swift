//
//  SignInViewController.swift
//  Zalo
//
//  Created by AnhLe on 05/04/2022.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK: - Subview
    private let descriptionView: UIView = GrayDescriptionBarView(content: "Bạn có thể đăng nhập bằng số điện thoại hoặc username")
    
    private let signInView = SignInView()
    
    private let forgetPasswordBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Lấy lại mật khẩu", for: .normal)
        button.setTitleColor(.blueZalo, for: .normal)
        button.addTarget(self, action: #selector(forgetBtnTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        return button
    }()
    
    private lazy var signInButton = CustomButton(text: "Đăng nhập", textColor: .white, backgroundColor: .blueThirdZalo, font: UIFont.preferredFont(forTextStyle: .headline))
    // MARK: - Properties
    typealias customValidation = SignInView.textfieldValidation
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupDissmissKeyboard()
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
    
    @objc func forgetBtnTapped(_ button: UIButton){
        print("DEBUG: forget Btn tapped")
    }
    
    @objc func signInBtnTapped(_ button: UIButton){
        print("DEBUG: sign In button tapped")
        signInView.validation()
    }
    
    // MARK: - API
    
    // MARK: - Helper
    private func configureNavBar(){
        self.navigationController?.navigationBar.barTintColor = .blueZalo
        self.navigationController?.navigationBar.barStyle = .black
        self.title = "Đăng nhập"
        
        let leftBarItem = UIBarButtonItem(image: Image.chevronLeft, style: .plain, target: self, action: #selector(backButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
}
// MARK: - Extension
extension SignInViewController {
    
    func style(){
        view.backgroundColor = .white        
        signInView.delegate = self
//        signInButton.isUserInteractionEnabled = false
        
        signInButton.addTarget(self, action: #selector(signInBtnTapped(_:)), for: .touchUpInside)
        signInButton.isUserInteractionEnabled = false
    }
    func layout(){
        
        view.addSubview(descriptionView)
        view.addSubview(signInView)
        view.addSubview(forgetPasswordBtn)
        view.addSubview(signInButton)
        
        //descriptionView
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
        ])
        //sign in view
        NSLayoutConstraint.activate([
            signInView.topAnchor.constraint(equalToSystemSpacingBelow: descriptionView.bottomAnchor, multiplier: 2),
            signInView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInView.trailingAnchor, multiplier: 2),
        
        ])
        
//        //forgetPasswordBtn
        NSLayoutConstraint.activate([
            forgetPasswordBtn.topAnchor.constraint(equalToSystemSpacingBelow: signInView.bottomAnchor, multiplier: 0),
            forgetPasswordBtn.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2)
        ])
        
        //sign in Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: forgetPasswordBtn.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 8),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 8)
        ])
    }
}

extension SignInViewController: SignInViewDelegate {
    func enableSignInButtonInteract() {
        signInButton.backgroundColor = signInView.userTextFieldAndPasswordTextFieldIsCompleted() ? .blueZalo : .blueThirdZalo
        signInButton.isUserInteractionEnabled = signInView.userTextFieldAndPasswordTextFieldIsCompleted() ? true : false
    }
    
    
}
