//
//  ApiService.swift
//  StockNov
//
//  Created by Aditya Haryanov on 23/10/20.
//

import Foundation

class ApiService {
    // IBM
    // 5min
    static let baseUrl = "https://www.alphavantage.co/query?"
    
    static func getTimeSeriesDailyAdjusted(symbol:String, apikey:String, completion: @escaping (Response?, Error?) -> ()) {
        
        let url = "\(self.baseUrl)function=TIME_SERIES_DAILY_ADJUSTED&symbol=\(symbol)&apikey=\(apikey)" //&outputsize=full
        
        self.get(urlStr: url, completion: completion)
    }
    
    static func getTimeSeriesIntraday(symbol:String, interval:String, apikey:String, completion: @escaping (Response?, Error?) -> ()) {
        
        let url = "\(self.baseUrl)function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=\(interval)&apikey=\(apikey)" //&outputsize=full
        
        self.get(urlStr: url, completion: completion)
    }
    
    
    static func get(urlStr:String, completion: @escaping (Response?, Error?) -> ()) {
        
        let url = URL(string: urlStr)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let err = error {
                completion(nil, err)
            }
            
            
            if let data = data {
                do {
                    
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    
                    completion(result, nil)
                    
                } catch let jsonErr {
                    completion(nil, jsonErr)
                }
            }
            
            
        }.resume()
        
    }
    
}
