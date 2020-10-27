//
//  StockIntradayViewModel.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation

class IntradayViewModel {
    
    var symbol : String
    var meta : MetaData?
    var stocks : [String : [Stock]]
    
    init() {
        symbol = "BABA"
        stocks = [String : [Stock]]()
    }
    
    func getData(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        let apiKey = App.apiKey
        let interval = App.userDefault.interval!
        let outputSize = (App.userDefault.outputSize == OutputSize.full)
        
        ApiService.getTimeSeriesIntraday(symbol: symbol, interval: interval, isFullOutput: outputSize, apikey: apiKey, completion: { (resp, err) in
            
            if let err = err as? AppError {
                error(err.getMessage())
            }
            
            if let resp = resp {
                
                var data = resp.toEntity()
                data.items?.sort(by: { $0.dateTime! > $1.dateTime! })
                self.meta = data.meta
                
                let myDictionary = Dictionary(grouping: data.items!, by: { $0.dateTime!.getDate() ?? "" })
                
                self.stocks.removeAll()
                self.stocks = myDictionary

                completion()
            }
            
        })
    }
    
    
}
