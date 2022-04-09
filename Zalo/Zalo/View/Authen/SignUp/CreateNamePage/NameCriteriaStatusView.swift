//
//  NameCriteriaStatusView.swift
//  Zalo
//
//  Created by AnhLe on 08/04/2022.
//

import UIKit

class NameCriteriaStatusView: UIView {
    // MARK: - Subview
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let nonSpecialCharacterCriteriaView = NameCriteriaView(content: "Không được chứa kí tự đặc biệt: #@!?:/'\'.,")
    let lengthCriteriaView = NameCriteriaView(content: "Gồm 2-40 kí tự")
    
    // MARK: - Properties
    var shouldResetCriteria: Bool = true
    
    var isMatchAllCriteria: Bool {
        return nonSpecialCharacterCriteriaView.isCriteriaMet && lengthCriteriaView.isCriteriaMet
    }
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
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
    func updateDisplay(_ text: String){
        let lengthCriteria = NameCriteria.lengthCriteriaMet(text)
        let noSpecialCharacter = NameCriteria.noSpecialCharacterMet(text)
        
        if shouldResetCriteria {
            lengthCriteria
                ? lengthCriteriaView.isCriteriaMet = true
                : lengthCriteriaView.reset()
            noSpecialCharacter
                ? nonSpecialCharacterCriteriaView.isCriteriaMet = true
                : nonSpecialCharacterCriteriaView.reset()
        }else{
            //end editing
            lengthCriteriaView.isCriteriaMet = lengthCriteria
            nonSpecialCharacterCriteriaView.isCriteriaMet = noSpecialCharacter
        }
        
        
    }
    
    
}
// MARK: - Extension

extension NameCriteriaStatusView {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        addSubview(stackView)
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(nonSpecialCharacterCriteriaView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}



