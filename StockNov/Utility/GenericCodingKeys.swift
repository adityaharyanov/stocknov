//
//  GenericCodingKeys.swift
//  StockNov
//
//  Created by Aditya Haryanov on 27/10/20.
//

import Foundation

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
