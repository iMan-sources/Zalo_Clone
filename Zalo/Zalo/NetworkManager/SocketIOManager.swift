import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    var socket: SocketIOClient!
    var nickName: String = "unknown"
    var friendList: [Friend] = []
    var messageList: [String:[Message]] = [:]
    var owerMessageList: [Message] = []
    var ownerId: String!
    // defaultNamespaceSocket and swiftSocket both share a single connection to the server
    let manager = SocketManager(socketURL: URL(string: "http://192.168.1.17:8080/")!, config: [.log(true), .compress])
    
    override init() {
        super.init()
        socket = manager.defaultSocket
        // thong bao co tin nhan den
        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
            let userID: String = dataArray[0] as! String
            let message: String = dataArray[1] as! String
            let newMessage: Message = Message(isRemoteMessage: true, message: message)

            if self.messageList[userID] == nil {
                self.messageList[userID] = []
            }

            self.messageList[userID]?.insert(newMessage, at: 0)
            
            
            NotificationCenter.default.post(name: Notification.Name("newChatMessage"), object: nil)
        }
    }
    
    func getFriendList(completion: @escaping([Friend])->Void){
        socket.on("updateFriendList") { ( dataArray, ack) -> Void in
            self.friendList.removeAll()
            let responseUserHash = dataArray[0] as! [String: String]
            for (userID, nickName) in responseUserHash {
                if userID != self.ownerId {
                    self.friendList.append(Friend(userID: userID, nickName: nickName))
                }

            }
            
            //Send notification for friendlist update
            completion(self.friendList)
        }
    }

    func connectSocket(_ onConnectedEvent:@escaping ()->Void) {
        socket.connect()
        socket.on("connect") {data, ack in
            onConnectedEvent()
//            let responseUserHash = data[0] as! [String: String]
            let responseUserHash = data[1] as! [String: String]
            self.ownerId = responseUserHash["sid"]
            print("socket connected")
        }
        
    }

    func receiveMsg() {
        socket.on("new message here") { (dataArray, ack) in
            print(dataArray.count)
        }
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func connectToServerWithNickname(nickname: String) {
        socket.emit("updateNickname", nickname)
    }
    
    func sendMessage(message: String, toUserID userID: String) {
        socket.emit("newChatMessage", userID, message)
        
    }
}

extension UITextView{

    func setPlaceholder() {

        let placeholderLabel = UILabel()
        placeholderLabel.text = "Enter some text..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (self.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !self.text.isEmpty

        self.addSubview(placeholderLabel)
    }

    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }

}

