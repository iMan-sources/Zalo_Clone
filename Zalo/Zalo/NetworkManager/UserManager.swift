//
//  UserManager.swift
//  Zalo
//
//  Created by AnhLe on 18/04/2022.
//

import Foundation
import Alamofire
class UserManager {
    static let shared = UserManager()
    
    func fetchUser(completion: @escaping(Result<[User], BaseUserError>) -> Void){
        AF.request(Configs.userBaseUrl).responseDecodable(of: [User].self) { response in
            switch response.result {
            case .failure(let error):
                print("DEBUG: \(error.localizedDescription)")
            case .success(let user):
                switch response.response?.statusCode {
                case 200 :
                    completion(.success(user))
                    break
                case 404:
                    completion(.failure(.parsedDataError))
                    break
                case .none:
                    completion(.failure(.parsedDataError))
                default:
                    completion(.failure(.parsedDataError))
                }

            }
        }
    }
}
