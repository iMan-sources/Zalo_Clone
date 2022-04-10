//
//  GrayDescriptionBarView.swift
//  Zalo
//
//  Created by AnhLe on 07/04/2022.
//

import UIKit

class GrayDescriptionBarView: UIView {
    // MARK: - Subview
    private let descriptionLabel = CustomLabel(content: "Bạn có thể đăng nhập bằng số điện thoại hoặc username", color: .darkGray, alignment: .left, fontFamily: UIFont.systemFont(ofSize: 15))
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    convenience init(content: String) {
        self.init(frame: .zero)
        descriptionLabel.text = content
    }
    
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
}
// MARK: - Extension

extension GrayDescriptionBarView {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGrayZalo
        
        
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 2
    }
    
    private func layout(){
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            descriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: descriptionLabel.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 1)
        
        ])
        
    }
}

