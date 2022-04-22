//
//  ConversationViewModel.swift
//  Zalo
//
//  Created by AnhLe on 20/04/2022.
//

import UIKit

class ConversationViewModel{
    var needReloadView: (()->Void)?
    
    var messages = [String]()
    var messageList: [Message] = [Message]()
    var selectedFriend: Friend!
    
    init(friend: Friend) {
        self.selectedFriend = friend
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        var numberOfRow = 0
        if let messageList = SocketIOManager.shared.messageList[selectedFriend.userID] {
            numberOfRow = messageList.count
        }
        return numberOfRow
    }
    
    
    func cellForRowAt(indexPath: IndexPath) -> String {
        if let messageList = SocketIOManager.shared.messageList[selectedFriend.userID] {
            return messageList[indexPath.row].message
        }
        return ""
        
    }
    
    
    func resizeSizeForRowAt(text: String) -> CGSize {
        let size = CGSize(width: UIScreen.main.bounds.width, height: .infinity)
        
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .callout)
        
//        if let messageList = SocketIOManager.shared.messageList[selectedFriend.userID] {
//            text = messageList[indexPath.row].message
//        }
        
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let extraDimesion: CGFloat = 32
        
        // if content stretch out screen
        if estimatedFrame.width >= UIScreen.main.bounds.width {
            return CGSize(width: UIScreen.main.bounds.width - 16, height: estimatedFrame.height + extraDimesion)
        }
        return CGSize(width: estimatedFrame.width + extraDimesion, height: estimatedFrame.height + extraDimesion)
        
    }
    
    func getMessagesAndReloadView(text: String){
        messages.insert(text, at: 0)
        self.needReloadView?()
    }
    
    func addMessage(message: Message){
        if SocketIOManager.shared.messageList[selectedFriend.userID] == nil {
            SocketIOManager.shared.messageList[selectedFriend.userID] = []
        }
        
        SocketIOManager.shared.messageList[selectedFriend.userID]?.append(message)
//        needReloadView?()
//        let lastRowIndex = max(0, self.messageList.count - 1)
//        self.tableView.insertRows(at: [NSIndexPath(row: lastRowIndex, section: 0) as IndexPath], with: UITableViewRowAnimation.none)
//        self.tableView.scrollRectToVisible((self.tableView.tableFooterView?.frame)!, animated: true)
        
        //add row in receiver
        

    }
    
    
    
    func sendMessage(text: String){
        if !text.isEmpty {
            var message: String = text.replacingOccurrences(of: "\n", with: "")
            message = message.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            SocketIOManager.shared.sendMessage(message: message, toUserID: selectedFriend.userID)
//            SocketIOManager.shared.updateMessage()
//            self.needReloadView?()
//            SocketIOManager.shared.receiveMsg { messages in
//                self.messageList.append(contentsOf: messages[self.selectedFriend.userID]!)
//                print("DEBUG: \(message)")
//                self.messageList = messages[self.selectedFriend.userID]!
//                self.needReloadView?()
//            }
//            self.addMessage(message: Message(isRemoteMessage: false, message: message))
            addMessage(message: Message(isRemoteMessage: false, message: message))
    
        }
    }
}
