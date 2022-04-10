//
//  BaseError.swift
//  Zalo
//
//  Created by AnhLe on 10/04/2022.
//

import Foundation

enum BaseError: Error {
    case requestError, parsedDataError, urlError
    
    public var title: String {
        switch self {
        case .requestError:
            return "Request failed"
        case .parsedDataError:
            return "Parsed data failed"
        case .urlError:
            return "Wrong Url"
        }
    }
    
    public var description: String {
        switch self {
        case .requestError:
            return "Request to server error. Please try again"
        case .parsedDataError:
            return "Parsed data from server failed. Please try again"
        case .urlError:
            return "URL failed. Please try again"
        }
    }
}
