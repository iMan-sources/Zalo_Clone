//
//  HomeViewModel.swift
//  Zalo
//
//  Created by AnhLe on 18/04/2022.
//

import Foundation
import Alamofire
class HomeViewModel{
    var needReloadView: (()->Void)?
    var needShowError: ((BaseUserError)->Void)?
    var users = [Friend]()
    
    
    func fetchUser(){
//        UserManager.shared.fetchUser { [weak self] result in
//            guard let self = self else {return}
//            switch result {
//            case .success(let users):
//                self.users = users
//                self.needReloadView?()
//            case .failure(let error):
//                self.needShowError?(error)
//            }
//        }
        SocketIOManager.shared.getFriendList { [weak self] friends in
            guard let self = self else {return}
            self.users = friends
            self.needReloadView?()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int{
        return users.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Friend {
        return users[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath) -> Friend{
        return users[indexPath.row]
    }
    
    
    
}
