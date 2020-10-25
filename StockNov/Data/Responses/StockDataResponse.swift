//
//  MetaDataResponse.swift
//  StockNov
//
//  Created by Aditya Haryanov on 23/10/20.
//

import Foundation

struct Response : Codable {
    //TO DO use [String : Any]
    var meta : MetaDataResponse?
    var data : [String : NodeResponse]?
    
    
    public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: GenericCodingKeys.self)
          for key in container.allKeys {
              if key.stringValue == "Meta Data" {
                  meta = try container.decode(
                      MetaDataResponse.self, forKey: key
                  )

                  continue
              }

              data = try container.decode(
                  [String: NodeResponse].self, forKey: key
              )
          }
      }
    
    
    func toEntity() -> StockData {
        
        let nodes = data!.map { key, value -> Node in
            
            let stock = value.toEntity(dateTime: key)
            
            return stock
        }
        
        return StockData(meta: meta!.toEntity(), nodes: nodes)

    }
}

struct StockData {
    
    var meta : MetaData?
    var nodes : [Node]?
    
}

struct MetaData {
    
    var information : String
    var symbol : String
    var lastRefreshed : Date?
    var interval : String
    var outputSize : String
    var timeZone : String
    
}

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

struct NodeResponse : Codable {

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
    
    func toEntity(dateTime : String) -> Node {
        
        return Node(
            dateTime: dateTime.convertToDate(),
            open: open ?? "",
            high: high ?? "",
            low: low ?? "",
            close: close ?? "",
            volume: volume ?? ""
        )
    }
    
}

struct Node {
    
    var dateTime : Date?
    var open : String
    var high : String
    var low : String
    var close : String
    var volume : String
    
}
