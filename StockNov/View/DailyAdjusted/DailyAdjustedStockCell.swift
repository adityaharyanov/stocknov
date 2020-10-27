//
//  DailyAdjustedStockCell.swift
//  StockNov
//
//  Created by Aditya Haryanov on 26/10/20.
//

import Foundation
import UIKit

class DailyAdjustedStockCell : UITableViewCell {
    
    static let Id = "DailyAdjustedStockCell"
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var baseStockOne: UIStackView!
    @IBOutlet weak var lblOpenStockOne: UILabel!
    @IBOutlet weak var lblLowStockOne: UILabel!
    
    @IBOutlet weak var baseStockTwo: UIStackView!
    @IBOutlet weak var lblOpenStockTwo: UILabel!
    @IBOutlet weak var lblLowStockTwo: UILabel!
    
    @IBOutlet weak var baseStockThree: UIStackView!
    @IBOutlet weak var lblOpenStockThree: UILabel!
    @IBOutlet weak var lblLowStockThree: UILabel!
    
}
