//
//  MetaDataResponse.swift
//  StockNov
//
//  Created by Aditya Haryanov on 23/10/20.
//

import Foundation

struct Response : Codable {

    var meta : MetaDataResponse?
    var data : [String : StockResponse]?
    
    
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
                  [String: StockResponse].self, forKey: key
              )
          }
      }
    
    
    func toEntity() -> StockData {
        
        let nodes = data!.map { key, value -> Stock in
            
            let stock = value.toEntity(dateTimeStr: key)
            
            return stock
        }
        
        return StockData(meta: meta!.toEntity(), items: nodes)

    }
}

