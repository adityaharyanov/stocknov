//
//  StockResponse.swift
//  StockNov
//
//  Created by Aditya Haryanov on 27/10/20.
//

import Foundation

struct StockResponse : Codable {

    var open : String?
    var high : String?
    var low : String?
    var close : String?
    var volume : String?
    
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
        
    }
    
    func toEntity(dateTimeStr : String) -> Stock {
        
        let date = dateTimeStr.convertToDate()
        
        return Stock(
            dateTime: date,
            open: open ?? "",
            high: high ?? "",
            low: low ?? "",
            close: close ?? "",
            volume: Int32(volume ?? "0") ?? 0
        )
    }
}
