//
//  StockDailyAdjustedViewModel.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation

class DailyAdjustedViewModel {
    
    var symbols : [String?] = [String?]()
    var stocks = [DailyAdjustedStockData]()
    
    init() {
        
    }
    
    func updateSymbols(isRemoved:Bool, value:String?, index: Int?, completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        if isRemoved {
            self.symbols.remove(at: index!)
            self.removeData(index: index!, completion: completion)
        } else {
            self.symbols.append(value!)
            self.getData(completion: completion, error: error)
        }
    }
    
    func removeData(index:Int, completion: @escaping () -> ()) {
        for i in 0..<self.stocks.count {
            switch index {
            case 0:
                self.stocks[i].stockOne = nil
            case 1:
                self.stocks[i].stockTwo = nil
            case 2:
                self.stocks[i].stockThree = nil
            default:
                print("Not Allowed")
            }
        }
        completion()
    }
    
    func getData(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        let apiKey = App.apiKey
        let outputSize = (App.userDefault.outputSize == OutputSize.full)
        
        self.stocks.removeAll()
        
        for i in 0..<symbols.count {
            let symbol = symbols[i]
            
            ApiService.getTimeSeriesDailyAdjusted(symbol: symbol!, apikey: apiKey, isFullOutput: outputSize, completion: { (resp, err) in
                
                if let err = err as? AppError {
                    error(err.getMessage())
                }
                
                if let resp = resp {
                    
                    var data = resp.toEntity()
                    data.items!.sort(by: { $0.dateTime! > $1.dateTime! })
                    
                    self.mergeStockData(newStockData: data.items!, index: i)
                    
                    completion()
                }
            })
        }

    }
    
    private func mergeStockData(newStockData:[Stock], index: Int) {

            newStockData.forEach({ item in
                
                let idx = self.stocks.firstIndex(where: { i in
                    i.date == item.dateTime
                })
                
                
                switch index {
                case 0:
                    if idx != nil {
                        self.stocks[idx!].stockOne = item
                    } else {
                        self.stocks.append(
                            DailyAdjustedStockData(
                                date: item.dateTime,
                                stockOne: item,
                                stockTwo: nil,
                                stockThree: nil))
                    }
                case 1:
                    if idx != nil {
                        self.stocks[idx!].stockTwo = item
                    } else {
                        self.stocks.append(
                            DailyAdjustedStockData(
                                date: item.dateTime,
                                stockOne: nil,
                                stockTwo: item,
                                stockThree: nil))
                    }
                case 2:
                    if idx != nil {
                        self.stocks[idx!].stockThree = item
                    } else {
                        self.stocks.append(
                            DailyAdjustedStockData(
                                date: item.dateTime,
                                stockOne: nil,
                                stockTwo: nil,
                                stockThree: item))
                    }
                default:
                    print("Not Allowed")
                }
                
            })
    }
}
