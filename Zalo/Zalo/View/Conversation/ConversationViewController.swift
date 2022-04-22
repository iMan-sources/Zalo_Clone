//
//  MessagingViewController.swift
//  Zalo
//
//  Created by AnhLe on 19/04/2022.
//

import UIKit

class ConversationViewController: UIViewController {
    // MARK: - Subview
    let messagingView = MessagingView()
    
    private var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    // MARK: - Properties
    var textHeightConstraint: NSLayoutConstraint!
    
    var friend: Friend!
    
    var conversationViewModel: ConversationViewModel!
    
    // MARK: - Lifecycle
    init(friend: Friend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        bindingViewModel()
        layout()
        configLeftNavVar()
        configRightNavBar()
        setupDissmissKeyboard()
        NotificationCenter.default.addObserver(forName: Notification.Name("newChatMessage"), object: nil, queue: nil, using: updateChatRoom)
    }
    

    
    // MARK: - Selector
    @objc func exitButtonTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - API
    
    // MARK: - Helper
    func updateChatRoom(_ notification: Notification) {
        DispatchQueue.main.async {
            print("DEBUG: reloading")
            self.tableView.reloadData()
        }
    }
    
    private func bindingViewModel(){
        conversationViewModel = ConversationViewModel(friend: friend)
        
        conversationViewModel.needReloadView = { [weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
            
        }
//        conversationViewModel.messages = conversationViewModel.messages.reversed()
        
    }
    
    
    
    private func configLeftNavVar(){
        let button = makeNavBarButton(image: Image.chevronLeft)
        button.addTarget(self, action: #selector(exitButtonTapped(_:)), for: .touchUpInside)
        let leftExitButton = UIBarButtonItem(customView: button)
        
        let titleButton = UIButton(type: .custom)
        titleButton.setTitle(friend.nickName, for: .normal)
        titleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        titleButton.setTitleColor(.white, for: .normal)
        
        let leftTitleButton = UIBarButtonItem(customView: titleButton)
        
        self.navigationItem.leftBarButtonItems = [leftExitButton, leftTitleButton]
    }
    
    
    private func configRightNavBar(){
        let phoneButton = makeNavBarButton(image: Image.phone)
        phoneButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        let rightPhoneButton = UIBarButtonItem(customView: phoneButton)
        
        
        let cameraButton = makeNavBarButton(image: Image.camera)
        cameraButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        let rightCameraButton = UIBarButtonItem(customView: cameraButton)
        
        let menuButton = makeNavBarButton(image: Image.menu)
        
        let rightMenuButton = UIBarButtonItem(customView: menuButton)
        
        
        self.navigationItem.rightBarButtonItems = [rightMenuButton,rightCameraButton, rightPhoneButton]
    }
    
    private func configTableView(){
        tableView.register(MessageCellSender.self, forCellReuseIdentifier: MessageCellSender.reuuseIdentifier)
        tableView.register(MessageCellReceiver.self, forCellReuseIdentifier: MessageCellReceiver.reuuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = MessageCellSender.rowHeight
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView.backgroundColor = .graySecondaryZalo
        
        
    }
    
    func addMessage(message: Message) {
        if SocketIOManager.shared.messageList[SocketIOManager.shared.ownerId] == nil {
            SocketIOManager.shared.messageList[SocketIOManager.shared.ownerId] = []
        }
        SocketIOManager.shared.messageList[SocketIOManager.shared.ownerId]?.insert(message, at: 0)
        self.tableView.reloadData()
                
//        let lastRowIndex = max(0, (SocketIOManager.shared.messageList[friend.userID]?.count)! - 1)
//        self.tableView.beginUpdates()
//        self.tableView.insertRows(at: [NSIndexPath(row: lastRowIndex, section: 0) as IndexPath], with: UITableView.RowAnimation.none)
//        self.tableView.endUpdates()
        
    }
    

}
// MARK: - Extension
extension ConversationViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        messagingView.delegate = self
        
        configTableView()
    }
    func layout(){
        view.addSubview(messagingView)
        view.addSubview(tableView)
        textHeightConstraint = messagingView.heightAnchor.constraint(equalToConstant: 40)

        
        // message view
        NSLayoutConstraint.activate([
            messagingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            messagingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            messagingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 12),
//            textHeightConstraint
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messagingView.topAnchor, constant: 0)
            
        ])
    }
}

extension ConversationViewController: MessagingViewDelegate {
    func sendButtonDidTapped(_ content: String) {
        
        var message: String = content.replacingOccurrences(of: "\n", with: "")
        message = message.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        SocketIOManager.shared.sendMessage(message: message, toUserID: friend.userID)
        addMessage(message: Message(isRemoteMessage: false, message: message))
    }
    
    func keyboardWillHide(_ newFrameY: CGFloat) {
        self.view.frame.origin.y += newFrameY
    }
    
    
    func keyboardWillShow(_ heightRiseUp: CGFloat) {
        self.view.frame.origin.y -= heightRiseUp
    }
    
    func textViewDidChange(height: CGFloat) {
        textHeightConstraint.constant = height
        self.view.layoutIfNeeded()
    }
}

extension ConversationViewController: UITableViewDelegate {
    
}

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        SocketIOManager.shared.messageList[friend.userID]?.count
//        return conversationViewModel.numberOfRowsInSection(section: section)
        print("DEBUG: \(SocketIOManager.shared.messageList)")
        return SocketIOManager.shared.messageList[SocketIOManager.shared.ownerId]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = SocketIOManager.shared.messageList[SocketIOManager.shared.ownerId]![indexPath.row]
        
        if !SocketIOManager.shared.messageList[SocketIOManager.shared.ownerId]![indexPath.row].isRemoteMessage {
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageCellSender.reuuseIdentifier, for: indexPath) as! MessageCellSender
            
            cell.bindingData(message: data.message,
                             size: conversationViewModel.resizeSizeForRowAt(text: data.message))
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCellReceiver.reuuseIdentifier, for: indexPath) as! MessageCellReceiver
        
        cell.bindingData(message: data.message,
                         size: conversationViewModel.resizeSizeForRowAt(text: data.message))
        
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = SocketIOManager.shared.messageList[SocketIOManager.shared.ownerId]![indexPath.row]
        let size = conversationViewModel.resizeSizeForRowAt(text: data.message)
        return size.height
    }
    
    
}
