//
//  CreatePhonePageViewController.swift
//  Zalo
//
//  Created by AnhLe on 09/04/2022.
//

import UIKit

class CreatePhoneViewController: SignupViewController {
    // MARK: - Subview
    let grayDescriptionView = GrayDescriptionBarView(content: "Nhập số điện thoại của bạn để tạo tài khoản mới")
    
    let countryTextField = AuthenTextField(placeholder: "")
    
    let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    // MARK: - Properties
    var countryViewModel: CountryViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupDissmissKeyboard()
        setDoneOnKeyboard()
        
        bindingViewModel()
    }
    
    // MARK: - Selector
    @objc func didCountrySelectionTapped(_: UITapGestureRecognizer){
        print("DEBUG: didCountrySelectionTapped..")
    }
    
    // MARK: - API
    
    // MARK: - Helper
    private func bindingViewModel(){
        countryViewModel = CountryViewModel()
        countryViewModel.fetchData()
//        countryViewModel.needReloadTableView = { [weak self] in
//            guard let self = self else {return}
//            print("DEBUG: \(self.countryViewModel.names)")
//            print("DEBUG: \(self.countryViewModel.codes)")
//        }
        
        
    }
}
// MARK: - Extension
extension CreatePhoneViewController {
    
    func style(){
        textField = NameTextField(placeholder: "Số điện thoại")
        configCountryTextField()
    }
    func layout(){
        view.addSubview(grayDescriptionView)
        view.addSubview(textFieldStackView)
        
        textFieldStackView.addArrangedSubview(countryTextField)
        textFieldStackView.addArrangedSubview(textField)
        
        //gray description bar
        NSLayoutConstraint.activate([
            grayDescriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            grayDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            grayDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
        
        //textFieldStackView
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalToSystemSpacingBelow: grayDescriptionView.bottomAnchor, multiplier: 4),
            textFieldStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textFieldStackView.trailingAnchor, multiplier: 2)
        
        ])
    }
    
    private func configCountryTextField(){
        countryTextField.textfield.isEnabled = false
        countryTextField.textfield.text = "VN"
        countryTextField.widthAnchor.constraint(equalToConstant: 48).isActive = true
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = Image.triangleDown.withConfiguration(configuration)
        button.setImage(image.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        countryTextField.textfield.rightView = button
        countryTextField.textfield.rightViewMode = .always
        
        //add target
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCountrySelectionTapped(_:)))
        countryTextField.addGestureRecognizer(gesture)
    }
    
}
