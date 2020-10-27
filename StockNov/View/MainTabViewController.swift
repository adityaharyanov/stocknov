//
//  MainTabViewController.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation
import UIKit

class MainTabViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "StockNov App"
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
}
