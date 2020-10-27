//
//  StockSearchViewModel.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation

class StockSearchViewModel {
    
    var symbol : String
    var stockPairs : [StockPair]
    
    init() {
        symbol = ""
        stockPairs = [StockPair]()
    }
    
    
    func getStockPairs(completion: @escaping () -> (), error: @escaping (String) -> ()) {
            
        let apiKey = App.apiKey
        let interval = App.userDefault.interval!
        let outputSize = (App.userDefault.outputSize == OutputSize.full)
        
        ApiService.getSymbolSearch(symbol: self.symbol, apikey: apiKey, completion: { (resp, err) in
            
            if let err = err as? AppError {
                error(err.getMessage())
            }
            
            if let resp = resp {
                
                var data : [StockPairResponse] = resp["bestMatches"]!
                
                var result = data.map({ item in item.toEntity() })
                
                result.sort(by: { $0.symbol < $1.symbol })
                
                self.stockPairs.removeAll()
                self.stockPairs.append(contentsOf: result)

                completion()
            }
            
        })
    }
    
}
