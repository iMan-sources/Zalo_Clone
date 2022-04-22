//
//  MessageCell.swift
//  Zalo
//
//  Created by AnhLe on 20/04/2022.
//

import UIKit

class MessageCellSender: UITableViewCell {
    // MARK: - Subview
        
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Test message"
        textView.textColor = .black
        textView.isEditable = false
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blueZalo.cgColor
        textView.font = UIFont.preferredFont(forTextStyle: .callout)

        return textView
    }()
    
    // MARK: - Properties
    var senderContraints: NSLayoutConstraint?, receiverConstraints: NSLayoutConstraint?
    var isSender: Bool = false
    
    static let reuuseIdentifier = "MessageCell"
    
    static let rowHeight: CGFloat = 88
    
    var cellSize: CGSize!
    
    var widthCellAnchor: NSLayoutConstraint!
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
    func bindingData(message: String, size: CGSize){
        messageTextView.text = message
        if size.width > UIScreen.main.bounds.width - 8 {
            widthCellAnchor.constant = UIScreen.main.bounds.width - 16
        }else{
            widthCellAnchor.constant = size.width
            
        }
    }
}
// MARK: - Extension

extension MessageCellSender {
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        self.selectionStyle = .none
        self.backgroundColor = .graySecondaryZalo
        
    }
    
    private func layout(){
        contentView.addSubview(messageTextView)
//
        receiverConstraints = messageTextView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1)

        senderContraints = contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: messageTextView.trailingAnchor, multiplier: 1)
        
        widthCellAnchor = messageTextView.widthAnchor.constraint(equalToConstant: 200)
        
        NSLayoutConstraint.activate([
            messageTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            widthCellAnchor,
            messageTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
            senderContraints!
            //default
//            senderContraints!
            

        ])
        
        
    }
}

extension UITextView {
    func simple_scrollToBottom() {
        let textCount: Int = text.count
        guard textCount >= 1 else { return }
        scrollRangeToVisible(NSRange(location: textCount - 1, length: 1))
    }
}

