//
//  AuthenTextField.swift
//  Zalo
//
//  Created by AnhLe on 06/04/2022.
//

import UIKit
protocol AuthenTextFieldDelgate: AnyObject {
    func didTextFieldEndEditing(_ sender: AuthenTextField)
    func didTextFieldChanged(_ sender: AuthenTextField)
}
class AuthenTextField: UIView {
    // MARK: - Subview
    let textfield: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.preferredFont(forTextStyle: .body)
        textfield.textColor = .black
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(textfieldEditingChanged(_:)), for: .editingChanged)
        return textfield
    }()
    
    private let dividerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    
    // MARK: - Properties
    var dividerHeightAnchor: NSLayoutConstraint!
    weak var delegate: AuthenTextFieldDelgate?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        textfield.attributedPlaceholder = makeAttributePlaceholder(text: placeholder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //give default size, if they put into stackview, this view will know how to size itself
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 48)
    }
    
    // MARK: - Selector
    @objc func textfieldEditingChanged(_ sender: UITextField){
        delegate?.didTextFieldChanged(self)
    }
    
    // MARK: - API
    
    // MARK: - Helper
    
    private func makeAttributePlaceholder(text: String) -> NSAttributedString{
        var plainAttrs = [NSAttributedString.Key: AnyObject]()
        plainAttrs[.foregroundColor] = UIColor.darkGray
        plainAttrs[.font] = UIFont.preferredFont(forTextStyle: .callout)
        let attrs = NSMutableAttributedString(string: text, attributes: plainAttrs)
        
        return attrs
    }
}
// MARK: - Extension

extension AuthenTextField {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
    }
    
    private func layout(){
        addSubview(stackView)
        stackView.addArrangedSubview(textfield)
        stackView.addArrangedSubview(dividerView)
        //stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        //dividerView
        dividerHeightAnchor = dividerView.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([
            dividerHeightAnchor
        
        ])
        textfield.setContentHuggingPriority(.defaultLow, for: .vertical)
        dividerView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    
}

extension AuthenTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.dividerHeightAnchor.constant = 2
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn, animations: {
            self.dividerHeightAnchor.constant = 2
            self.dividerView.backgroundColor = .cyanBlueZalo
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        dividerHeightAnchor.constant = 1
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.dividerHeightAnchor.constant = 1
            self.dividerView.backgroundColor = .lightGray
            self.layoutIfNeeded()
        }, completion: nil)
        delegate?.didTextFieldEndEditing(self)
    }
}

