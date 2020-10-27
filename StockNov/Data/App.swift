//
//  App.swift
//  StockNov
//
//  Created by Aditya Haryanov on 23/10/20.
//

import Foundation

class App {
    
    static var apiKey : String {
        return keyChain.getApiKey()
    }
    static let userDefault = UserDefaultService()
    static let keyChain = KeyChainService()
    
}
