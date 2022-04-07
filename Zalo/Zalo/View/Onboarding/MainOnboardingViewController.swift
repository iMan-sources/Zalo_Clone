//
//  MainOnboardingViewController.swift
//  Zalo
//
//  Created by AnhLe on 05/04/2022.
//

import UIKit

class MainOnboardingViewController: UIViewController {
    // MARK: - Subview
    private let onboarding = OnboardingContainerViewController()
    private let onboardingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackButtonView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var signInButton = CustomButton(text: "Đăng nhập", textColor: .white, backgroundColor: .blueZalo, font: UIFont.preferredFont(forTextStyle: .body))
    
    private lazy var signUpButton = CustomButton(text: "Đăng ký", textColor: .black, backgroundColor: .lightGrayZalo, font: UIFont.preferredFont(forTextStyle: .body))
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    // MARK: - Selector
    @objc func signInButtonTapped(_ sender: UIButton){
        let vc = SignInViewController()
        self.navigationController?.pushViewController( vc, animated: true)
    }
    
    @objc func signUpButtonTapped(_ sender: UIButton){
        let vc = CreateAccountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - API
    
    // MARK: - Helper
}
// MARK: - Extension
extension MainOnboardingViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        onboardingView.backgroundColor = .clear
        
        //bring onboarding vc to view
        addChild(onboarding)
        onboardingView.addSubview(onboarding.view)
        onboarding.view.frame = onboardingView.bounds
        onboarding.didMove(toParent: self)
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
        
    }
    func layout(){
        view.addSubview(onboardingView)
        view.addSubview(stackButtonView)
        
        stackButtonView.addArrangedSubview(signInButton)
        stackButtonView.addArrangedSubview(signUpButton)

        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingView.heightAnchor.constraint(equalToConstant: view.bounds.height * 3/5)
        ])
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stackButtonView.bottomAnchor, multiplier: 2),
            stackButtonView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackButtonView.trailingAnchor, multiplier: 5)
        
        ])
    }
}
