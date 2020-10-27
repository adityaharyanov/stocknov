//
//  File.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation

struct StockPairResponse : Codable {
    
    var symbol : String
    var name : String
    
    enum CodingKeys : String, CodingKey {
        
        case symbol = "1. symbol"
        case name = "2. name"
    }
    
    func toEntity() -> StockPair {
        return StockPair(symbol: symbol, name: name)
    }
}
