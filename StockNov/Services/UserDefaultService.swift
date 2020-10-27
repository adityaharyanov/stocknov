//
//  UserDefaultService.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation

class UserDefaultService {
    
    private let instance = UserDefaults.standard
    
    private let outputSizeKey = "outputSize"
    private let intervalKey = "interval"
    
    
    var outputSize : OutputSize? {
        get  {
            let tmp = instance.integer(forKey: outputSizeKey)
            
            if tmp == 0 {
                return nil
            }
            
            return OutputSize(rawValue: tmp)
        }
        
        set(value) {
            instance.set(value?.rawValue, forKey: outputSizeKey)
        }
    }
    
    var interval : String? {
        get  {
            return instance.string(forKey: intervalKey)
        }
        
        set(value) {
            let result = instance.set(value, forKey: intervalKey)
        }
    }
    
}
