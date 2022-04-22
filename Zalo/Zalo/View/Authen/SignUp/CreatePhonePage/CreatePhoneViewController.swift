//
//  CreatePhonePageViewController.swift
//  Zalo
//
//  Created by AnhLe on 09/04/2022.
//

import UIKit
class CreatePhoneViewController: SignupViewController{
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
    
    private let errorLabel: UILabel = CustomLabel(content: "Số điện thoại không hợp lệ", color: .systemRed, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .body))
    // MARK: - Properties
    var countryViewModel: CountryViewModel!
    
    var errorLabelHeightAnchor: NSLayoutConstraint!
    
    var isCriteriaValid: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupDissmissKeyboard()
        setDoneOnKeyboard()
        configFooterAndToolBar()
        bindingViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //save phoneNumber newUser
        guard let phoneNumber = textField.text, let code = countryTextField.text else {return}
        
//        CreateAccountViewController.user.setPhoneNumber(number: phoneNumber)
//        CreateAccountViewController.user.setCountryCode(code: code)
    }
    
    // MARK: - Selector
    @objc func didCountrySelectionTapped(_: UITapGestureRecognizer){
        let vc = CountryCodeViewController(viewModel: countryViewModel)
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    // MARK: - Helper
    private func bindingViewModel(){
        countryViewModel = CountryViewModel()
        countryViewModel.fetchData()
    }
    private func configNextButton(){
        footerView.nextButton.backgroundColor = isCriteriaValid ? .blueZalo : .lightBlueGrayZalo
        footerView.nextButton.isUserInteractionEnabled = isCriteriaValid ? true : false
        toolbarView.nextButton.backgroundColor = footerView.nextButton.backgroundColor
        toolbarView.nextButton.isUserInteractionEnabled = footerView.nextButton.isUserInteractionEnabled
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
            let vc = CreatePasswordViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            animateErrorLabel()
        }
        
    }

}
// MARK: - Extension
extension CreatePhoneViewController {
    
    func style(){
        textField = NameTextField(placeholder: "Số điện thoại")
        configCountryTextField()
        textField.delegate = self
        textField.textfield.keyboardType = .numberPad
        
    }
    func layout(){
        view.addSubview(grayDescriptionView)
        view.addSubview(textFieldStackView)
        view.addSubview(errorLabel)
        
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
        errorLabelHeightAnchor = errorLabel.heightAnchor.constraint(equalToConstant: 0)
        //error label
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: textFieldStackView.bottomAnchor, multiplier: 1),
            errorLabel.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor),
            errorLabelHeightAnchor
            
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

extension CreatePhoneViewController: CountryCodeViewControllerDelegate {
    func didCountryCodeTapped(country: CountryPhone) {
        countryTextField.textfield.text = country.name
    }
}

extension CreatePhoneViewController: AuthenTextFieldDelgate {
    func didTextFieldEndEditing(_ sender: AuthenTextField) {
        //enable background & userInteract
        animateErrorLabel()
        configNextButton()

    }
    
    func didTextFieldChanged(_ sender: AuthenTextField) {
        //enable background & userInteract
        if let text = sender.textfield.text {
            toolbarView.nextButton.backgroundColor =  !text.isEmpty ? .blueZalo : .lightBlueGrayZalo
            toolbarView.nextButton.isUserInteractionEnabled = !text.isEmpty ? true : false
            
            isCriteriaValid = AuthenCriteria.isNumberAndLength(text)
        }
    }
    
}

