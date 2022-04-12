//
//  CountryCodeCustomHeaderView.swift
//  Zalo
//
//  Created by AnhLe on 12/04/2022.
//

import UIKit

class CountryCodeCustomHeaderCell: UITableViewHeaderFooterView {
    // MARK: - Subview
    private let letterLabel = CustomLabel(content: "VietNam", color: .black, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .footnote))
    
    // MARK: - Properties
    static let reuseIdentifier = "CountryCodeCustomHeaderCell"
    static let rowHeight: CGFloat = 38
    // MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
    func bindingData(letter: String){
        letterLabel.text = letter
    }
}
// MARK: - Extension
extension CountryCodeCustomHeaderCell {
    
    func setup(){
        contentView.backgroundColor = .systemBackground
    }
    func layout(){
        contentView.addSubview(letterLabel)
        
        NSLayoutConstraint.activate([
            letterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            letterLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2)
        ])
    }
}
