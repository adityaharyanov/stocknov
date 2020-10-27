//
//  StockCell.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation
import UIKit

class IntradayStockCell : UITableViewCell {
    
    static let Id = "IntradayStockCell"
    static let sectionId = "IntradayStockSection"
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblOpen: UILabel!
    @IBOutlet weak var lblHigh: UILabel!
    @IBOutlet weak var lblLow: UILabel!
    
    
}
