//
//  CustomLabel.swift
//  Zalo
//
//  Created by AnhLe on 03/04/2022.
//

import UIKit

class CustomLabel: UILabel {
    // MARK: - Subview
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLabel()
    }
    
    convenience init(content: String, color: UIColor, alignment: NSTextAlignment, fontFamily: UIFont) {
        self.init(frame: .zero)
        text = content
        textColor = color
        textAlignment = alignment
        font = fontFamily
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
    private func configLabel(){
        translatesAutoresizingMaskIntoConstraints = false
    }
}

