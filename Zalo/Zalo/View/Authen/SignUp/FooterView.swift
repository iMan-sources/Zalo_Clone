//
//  FooterView.swift
//  Zalo
//
//  Created by AnhLe on 08/04/2022.
//

import UIKit
protocol FooterViewDelegate: AnyObject {
    func didNextButtonTapped()
}
class FooterView: UIView {
    // MARK: - Subview
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView : UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightBlueGrayZalo
        button.setImage(Image.nextImage, for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    // MARK: - Properties
    private let buttonDimension: CGFloat = 42
    
    weak var delegate: FooterViewDelegate?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - Selector
    @objc func nextButtonTapped(_ sender: UIButton){
        delegate?.didNextButtonTapped()
    }
    
    // MARK: - API
    
    // MARK: - Helper
    private func makeAttributedText() -> NSAttributedString{
        var plainAttrs = [NSAttributedString.Key: AnyObject]()
        plainAttrs[.foregroundColor] = UIColor.lightGray
        plainAttrs[.font] = UIFont.preferredFont(forTextStyle: .callout)
        
        var blueAttrs = [NSAttributedString.Key: AnyObject]()
        blueAttrs[.foregroundColor] = UIColor.blueZalo
        blueAttrs[.font] = UIFont.preferredFont(forTextStyle: .callout)
        
        let attrs = NSMutableAttributedString(string: "Tiếp tục nghĩa là bạn đồng ý với các ", attributes: plainAttrs)
        attrs.append(NSAttributedString(string: "điều khoản sử dụng Zalo", attributes: blueAttrs))
        
        return attrs
    }
}
// MARK: - Extension

extension FooterView {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
        
        label.attributedText = makeAttributedText()
        nextButton.layer.cornerRadius = buttonDimension / 2
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        nextButton.isUserInteractionEnabled = false
        
    }
    
    private func layout(){
        addSubview(stackView)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(nextButton)
        
        //button
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: buttonDimension),
            nextButton.widthAnchor.constraint(equalTo: nextButton.heightAnchor)
        
        ])
        
        //stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
        nextButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    

}

