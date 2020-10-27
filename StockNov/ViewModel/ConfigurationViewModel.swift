//
//  StockConfigViewModel.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation

class ConfigurationViewModel {
    
    var apiKey : String
    var selectedOutputSize : Int
    var selectedInterval : Int
    
    let intervals = [
        "1min", "5min", "15min", "30min", "60min"
    ]

    init() {
        //TODO: Load from KeyChain
        apiKey = App.apiKey
        selectedOutputSize = App.userDefault.outputSize?.rawValue ?? 0
        selectedInterval =  intervals.firstIndex(of: App.userDefault.interval ?? "") ?? -1
    }
    
    
}
