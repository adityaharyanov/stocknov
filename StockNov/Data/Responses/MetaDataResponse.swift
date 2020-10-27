//
//  MetaDataResponse.swift
//  StockNov
//
//  Created by Aditya Haryanov on 27/10/20.
//

import Foundation

struct MetaDataResponse : Codable {
    
    var information : String?
    var symbol : String?
    var lastRefreshed : String?
    var interval : String?
    var outputSize : String?
    var timeZone : String?
    
    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timeZone = "6. Time Zone"
        
    }
    
    func toEntity() -> MetaData {
        
        return MetaData(
            information: information  ?? "",
            symbol: symbol ?? "",
            lastRefreshed: lastRefreshed?.convertToDate(),
            interval: interval ?? "",
            outputSize: outputSize ?? "",
            timeZone: timeZone ?? ""
        )
    }
    
}
