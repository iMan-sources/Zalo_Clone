//
//  HomeTableCell.swift
//  Zalo
//
//  Created by AnhLe on 15/04/2022.
//

import UIKit

class HomeTableCell: UITableViewCell {
    // MARK: - Subview
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         
         imageView.clipsToBounds = true
         return imageView
     }()
    
    private let avatarView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 58).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        view.layer.cornerRadius = 58 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blueZalo
        return view
    }()
    
    private let avatarLabel = CustomLabel(content: "A", color: .white, alignment: .center, fontFamily: UIFont.preferredFont(forTextStyle: .title2))
    
    private let userLabel = CustomLabel(content: "Anh Le", color: .black, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .body))
    
    private let contentLabel = CustomLabel(content: "Iem an com chua", color: .lightGray, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .body))
    
    private let labelStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.spacing = 8
        return stackView
    }()
    
    
    // MARK: - Properties
    static let reuseIdentifier = "HomeTableCell"
    static let rowHeight: CGFloat = 72
    
    var user: Friend?{
        didSet{
            self.bindingData()
        }
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper

    private func bindingData(){
        guard let user = user else {return}
        let name = user.nickName
        avatarLabel.text = String(name.prefix(1))
        userLabel.text = name
        
    }
}
// MARK: - Extension
extension HomeTableCell {
    
    func setup(){
        contentLabel.lineBreakMode = .byTruncatingTail
        
        userLabel.lineBreakMode = .byTruncatingTail
        
        self.selectionStyle = .none
        
        
    }
    func layout(){
        configAvatarView()
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(labelStackView)
        
        labelStackView.addArrangedSubview(userLabel)
        labelStackView.addArrangedSubview(contentLabel)
        
        //stackView
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
        
        avatarView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
//        userLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        contentLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    private func configAvatarView(){
        avatarView.addSubview(avatarImage)
        avatarView.addSubview(avatarLabel)
        
        //avatarImage
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: avatarView.topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            avatarImage.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
            avatarImage.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor)
        ])
        
        //avatarLabel
        NSLayoutConstraint.activate([
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor)
        
        ])
        
        
    }
}
