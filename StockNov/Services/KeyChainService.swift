//
//  KeyChainService.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation
import Security

class KeyChainService {
    
    let apiKeyAccount = "apiKey"
    
    
    func setApiKey(newApiKey: String) -> Bool {
        
        let keychainItemQuery = [
          kSecValueData: newApiKey.data(using: .utf8)!,
          kSecAttrAccount: apiKeyAccount,
          kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status  : OSStatus = SecItemAdd(keychainItemQuery, nil)
        
        return (status == noErr)
    }
    
    func getApiKey() -> String {
        
        let query = [
          kSecClass: kSecClassGenericPassword,
          kSecAttrAccount: apiKeyAccount,
          kSecReturnData: true,
          kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var result: AnyObject?
        
        let lastResultCode : OSStatus = withUnsafeMutablePointer(to: &result) {
          SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if lastResultCode == noErr {
            if let data = result as? Data {
            
                if let currentString = String(data: data, encoding: .utf8) {
                   return currentString
                }
            }
        }
        
        return ""
    }
    
    func updateApiKey(newApiKey: String) -> Bool {
        
        let query = [
          kSecClass: kSecClassGenericPassword,
          kSecAttrAccount: apiKeyAccount,
        ] as CFDictionary

        let updateFields = [
          kSecValueData: newApiKey.data(using: .utf8)!,
        ] as CFDictionary
        
        let status = SecItemUpdate(query, updateFields)
        
        return (status == noErr)
    }
    
    
    
    
    
}
