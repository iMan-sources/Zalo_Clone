//
//  User.swift
//  Zalo
//
//  Created by AnhLe on 14/04/2022.
//

import UIKit

struct User: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let avatar: String
    let id: String
}

//struct User {
//    var name: String?
//    var phoneNumber: String?
//    var password: String?
//    var countryCode: String?
//
////    init(name: String? = nil, phoneNumber: String? = nil, password: String? = nil){
////        self.name = name
////        self.phoneNumber = phoneNumber
////        self.password = password
////    }
//
//    mutating func setName(name: String){
//        self.name = name
//    }
//
//    mutating func setPhoneNumber(number: String){
//        self.phoneNumber = number
//    }
//
//    mutating func setPassword(password: String){
//        self.password = password
//    }
//
//    mutating func setCountryCode(code: String){
//        self.countryCode = code
//    }
//}
