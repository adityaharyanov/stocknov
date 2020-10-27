//
//  TypeEnum.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation

enum OutputSize: Int {
    case none = 0
    case compact = 1
    case full = 2
}

enum AppError: Error {
    case apiError(String)
    
    func getMessage() -> String {
        var message = ""
        switch self {
            case let .apiError(reason):
                message = reason
            default:
                message = self.localizedDescription
        }
        
        return message;
    }
    
}
