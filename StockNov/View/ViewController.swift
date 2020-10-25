//
//  ViewController.swift
//  StockNov
//
//  Created by Aditya Haryanov on 23/10/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ApiService.getTimeSeriesDailyAdjusted(symbol: "IBM", apikey: "demo") { (resp, err) in
            
            if let resp = resp {
                
                let data = resp.toEntity()
                
                print(data)
            }
            
            if let err = err {
                print(err)
            }
            
        }
    }


}

