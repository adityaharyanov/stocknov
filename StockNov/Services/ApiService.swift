//
//  ApiService.swift
//  StockNov
//
//  Created by Aditya Haryanov on 23/10/20.
//

import Foundation

class ApiService {

    static let baseUrl = "https://www.alphavantage.co/query?"
    
    static func getTimeSeriesDailyAdjusted(symbol:String, apikey:String, isFullOutput:Bool, completion: @escaping (Response?, Error?) -> ()) {
        
        var url = "\(self.baseUrl)function=TIME_SERIES_DAILY_ADJUSTED&symbol=\(symbol)&apikey=\(apikey)" //&outputsize=full
        
        if isFullOutput {
            url += "&outputsize=full"
        }
        
        self.get(type: Response.self, urlStr: url, completion: completion)
    }
    
    static func getTimeSeriesIntraday(symbol:String, interval:String, isFullOutput:Bool, apikey:String, completion: @escaping (Response?, Error?) -> ()) {
        
        var url = "\(self.baseUrl)function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=\(interval)&apikey=\(apikey)"
        
        if isFullOutput {
            url += "&outputsize=full"
        }
        
        self.get(type: Response.self, urlStr: url, completion: completion)
    }
    
    static func getSymbolSearch(symbol:String, apikey:String, completion: @escaping ([String : [StockPairResponse]]?, Error?) -> ()) {
        
        let url = "\(self.baseUrl)function=SYMBOL_SEARCH&keywords=\(symbol)&apikey=\(apikey)"
        
        self.get(type: [String : [StockPairResponse]].self, urlStr: url, completion: completion)
    }
    
    
    static func get<T : Decodable>(type: T.Type, urlStr:String, completion: @escaping (T?, Error?) -> ()) {
        
        let url = URL(string: urlStr)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let err = error {
                completion(nil, err)
            }
            
            if let data = data {
                
                do {
                    
                    let result = try JSONDecoder().decode([String:String].self, from: data)
                    
                    completion(nil, AppError.apiError("\(result.keys.first!) : \(result.values.first!)"))
                    return
                } catch {
                    
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(T.self, from: data)
                    
                    completion(result, nil)
                    
                } catch let jsonErr {
                    completion(nil, jsonErr)
                }
            }
            
            
        }.resume()
        
    }
    
}
