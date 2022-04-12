//
//  CountryCodeTableViewCell.swift
//  Zalo
//
//  Created by AnhLe on 11/04/2022.
//

import UIKit

class CountryCodeTableViewCell: UITableViewCell {
    // MARK: - Subview
    private let countryNameLabel = CustomLabel(content: "VietNam", color: .black, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .body))
    
    private let countryCodeLabel = CustomLabel(content: "+84", color: .darkGrayZalo, alignment: .right, fontFamily: UIFont.preferredFont(forTextStyle: .callout))
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    static let reuseIdentifier = "CountryCodeTableViewCell"
    static let rowHeight: CGFloat = 80
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
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
    func bindData(country: CountryPhone){
        countryNameLabel.text = country.shorthand
        countryCodeLabel.text = country.code
    }
}
// MARK: - Extension

extension CountryCodeTableViewCell {
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
        
        countryNameLabel.adjustsFontSizeToFitWidth = true
        countryNameLabel.minimumScaleFactor = 0.8
    }
    
    private func layout(){
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(countryNameLabel)
        stackView.addArrangedSubview(countryCodeLabel)
        
        //countryNameLabel
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 4)
        ])
        
        countryNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        countryCodeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
}


