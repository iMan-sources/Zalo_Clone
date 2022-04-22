//
//  MessagingView.swift
//  Zalo
//
//  Created by AnhLe on 19/04/2022.
//

import UIKit
protocol MessagingViewDelegate: AnyObject {
    func textViewDidChange(height: CGFloat)
    
    func keyboardWillShow(_ newFrameY: CGFloat)
    
    func keyboardWillHide(_ newFrameY: CGFloat)
    
    func sendButtonDidTapped(_ content: String)
}
class MessagingView: UIView {
    // MARK: - Subview
    private let textView: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.autocorrectionType = .no
        return textView
    }()

    private let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Image.send, for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    var textHeightConstraint: NSLayoutConstraint!
    private let maxHeight: CGFloat = 40
    var newFrameY: CGFloat = 0 
    weak var delegate: MessagingViewDelegate?
    var textWillSend: String = ""
    let bottomSafeArea: CGFloat = 34
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        setupKeyboardNoti()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Selector
    @objc func sendButtonTapped(_ sender: UIButton){
//        textView.resignFirstResponder()
//        textView.endEditing(true)
        
        delegate?.sendButtonDidTapped(self.textWillSend)
//        textView.text = "Tin nhắn"
//        textView.heightnchor.constraint(equalToConstant: 40).isActive = true
        self.layoutIfNeeded()
        
        textView.text = "Tin nhắn"
        textView.textColor = UIColor.lightGray

        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        
//        textHeightConstraint.constant = 40
        
    }
    
    @objc func keyboardWillShow(_ sender: NSNotification){
        guard let userinfor = sender.userInfo,
              let keyboardFrame = userinfor[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentView = UIResponder.currentFirst() as? UITextView else {return}
        
        // Y of keyboard
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        
        //bottom y of uitextview
//        let currentTextViewFrame = self.convert(textView.frame, to: textView.superview)
        var textViewBottomY: CGFloat = 0
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            let locationInWindow = self.convert(currentView.frame, to: window)
            
            textViewBottomY = locationInWindow.origin.y + currentView.frame.height
            if textViewBottomY > keyboardTopY {
                let newFrameY = keyboardFrame.cgRectValue.size.height
                self.newFrameY = newFrameY
                delegate?.keyboardWillShow(newFrameY)
            }
        }
        
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification){
        delegate?.keyboardWillHide(newFrameY)
    }
    
    // MARK: - API
    
    // MARK: - Helper
    
    private func setupKeyboardNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
// MARK: - Extension

extension MessagingView {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.isScrollEnabled = false

        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        textView.text = "Tin nhắn"
    }
    
    private func layout(){
        addSubview(textView)
        addSubview(sendButton)
        textHeightConstraint = textView.heightAnchor.constraint(equalToConstant: maxHeight)


        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
//                textHeightConstraint
         ])
        
        NSLayoutConstraint.activate([
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            sendButton.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 0),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}

extension MessagingView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        
   
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
//        if textView.text == "Tin nhắn"{
//            textView.text = ""
//        }
        
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        if estimatedSize.height < 80 {
            self.textHeightConstraint.constant = estimatedSize.height
        }else{
            NSLayoutConstraint.activate([
                textHeightConstraint
            ])
            self.textView.isScrollEnabled = true
        }
//        delegate?.textViewDidChange(height: estimatedSize.height)
        guard let text = textView.text, !text.isEmpty else {return}
        self.textWillSend = text

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text, !text.isEmpty else {return}
        self.textWillSend = text
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Tin nhắn"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}

