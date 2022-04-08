//
//  NameCriteria.swift
//  Zalo
//
//  Created by AnhLe on 08/04/2022.
//

import Foundation

struct NameCriteria {
    static func lengthCriteriaMet(_ text: String) -> Bool{
        return text.count >= 2 && text.count <= 40
    }
    
    static func noSpecialCharacterMet(_ text: String) -> Bool{
        return text.range(of: "[@:!?()$#,./\\\\]+", options: .regularExpression) == nil
    }
}
