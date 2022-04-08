//
//  NameCriteriaView.swift
//  Zalo
//
//  Created by AnhLe on 08/04/2022.
//

import UIKit

class NameCriteriaView: UIView {
    // MARK: - Subview
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label = CustomLabel(content: "", color: .darkGray, alignment: .left, fontFamily: UIFont.preferredFont(forTextStyle: .footnote))
    
    // MARK: - Properties
    var isCriteriaMet: Bool = false {
        didSet{
            imageView.image = isCriteriaMet
                ? Image.checkmarkImage.withTintColor(.systemGreen)
                : Image.xmarkImage.withTintColor(.systemRed)
        }
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
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    convenience init(content: String) {
        self.init(frame: .zero)
        label.text = content
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
    func reset(){
        isCriteriaMet = false
        imageView.image = Image.circleImage
    }
}
// MARK: - Extension

extension NameCriteriaView {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = Image.circleImage
        label.text = "Không được chứa kí tự đặc biệt: #@!?:/'\'.,"
        

    }
    
    private func layout(){
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        
        ])
        
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

