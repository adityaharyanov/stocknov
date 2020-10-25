//
//  Extensions.swift
//  StockNov
//
//  Created by Aditya Haryanov on 23/10/20.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        return dateFormatter.date(from: self)
        
    }
    
}

struct GenericCodingKeys: CodingKey {
    var intValue: Int?
    var stringValue: String

    init?(intValue: Int) {
        self.intValue = intValue
        stringValue = "\(intValue)"
    }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }
}
