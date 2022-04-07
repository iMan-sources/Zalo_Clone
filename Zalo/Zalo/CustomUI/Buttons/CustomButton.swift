//
//  CustomButton.swift
//  Zalo
//
//  Created by AnhLe on 05/04/2022.
//

import UIKit

class CustomButton: UIButton {
    // MARK: - Subview
    
    // MARK: - Properties
    let buttonHeight: CGFloat = 70
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    convenience init(text: String, textColor: UIColor, backgroundColor: UIColor, font: UIFont) {
        self.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor

        self.titleLabel?.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
}
// MARK: - Extension
extension CustomButton {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    func layout(){
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 50 / 2
    }
}
