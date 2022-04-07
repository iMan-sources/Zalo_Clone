//
//  AuthenCriteria.swift
//  Zalo
//
//  Created by AnhLe on 06/04/2022.
//

struct AuthenCriteria {
    static func lengthPhoneNumberMet(_ text: String)-> Bool{
        return text.count == 10
    }
    
    static func isNumber(_ text: String)->Bool{
        return text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    static func isNumberAndLength(_ text: String) -> Bool{
        return isNumber(text) && lengthPhoneNumberMet(text)
    }
    
    static func nonSpecialCharacterMet(_ text: String) -> Bool{
        return text.range(of: "[@:?!()$#,/\\\\]", options: .regularExpression) == nil
    }
}
