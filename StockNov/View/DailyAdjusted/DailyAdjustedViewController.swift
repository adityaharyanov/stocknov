//
//  DailyAdjustedViewController.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation
import UIKit

class DailyAdjustedViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel = DailyAdjustedViewModel()
    
    //IBOutlets
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddSymbol: UIButton!
    
    @IBOutlet weak var baseTitleStockOne: UIView!
    @IBOutlet weak var lblTitleStockOne: UILabel!
    @IBOutlet weak var btnRemoveStockOne: UIButton!
    
    @IBOutlet weak var baseTitleStockTwo: UIView!
    @IBOutlet weak var lblTitleStockTwo: UILabel!
    @IBOutlet weak var btnRemoveStockTwo: UIButton!
    
    @IBOutlet weak var baseTitleStockThree: UIView!
    @IBOutlet weak var lblTitleStockThree: UILabel!
    @IBOutlet weak var btnRemoveStockThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.btnAddSymbol.addTarget(self, action: #selector(openStockSearchPage), for: .touchUpInside)
        
        self.btnRemoveStockOne.addTarget(self, action: #selector(removeSelectedStock), for: .touchUpInside)
        self.btnRemoveStockTwo.addTarget(self, action: #selector(removeSelectedStock), for: .touchUpInside)
        self.btnRemoveStockThree.addTarget(self, action: #selector(removeSelectedStock), for: .touchUpInside)
    }
    
    @objc func removeSelectedStock(sender: UIButton) {
        let tag = sender.tag

        self.viewModel.updateSymbols(isRemoved: true, value: nil, index: tag, completion: self.success, error: self.showErrorAlert(message:))
    }
    
    @objc func openStockSearchPage(){
        
        if self.viewModel.symbols.count == 3 {
            self.showErrorAlert(message: "Cannot add more symbols. (max: 3 symbols)")
            return
        }
        
        performSegue(withIdentifier: "StockSearchSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! SearchStockViewController
        
        vc.completion = { symbol in
            
            self.viewModel.updateSymbols(isRemoved: false, value: symbol, index: nil, completion: self.success, error: self.showErrorAlert(message:))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyAdjustedStockCell.Id) as! DailyAdjustedStockCell
        let item = viewModel.stocks[indexPath.row]
        
        cell.lblDate.text = item.date?.getDate(customFormat: "dd-MM-yyyy")
        
        if let stock = item.stockOne {
            cell.lblOpenStockOne.text = stock.open
            cell.lblLowStockOne.text = stock.low
            
            cell.baseStockOne.isHidden = false
        } else {
            cell.baseStockOne.isHidden = true
        }
        
        if let stock = item.stockTwo {
            cell.lblOpenStockTwo.text = stock.open
            cell.lblLowStockTwo.text = stock.low
            
            cell.baseStockTwo.isHidden = false
        } else {
            cell.baseStockTwo.isHidden = true
        }
        
        if let stock = item.stockThree {
            cell.lblOpenStockThree.text = stock.open
            cell.lblLowStockThree.text = stock.low
            
            cell.baseStockThree.isHidden = false
        } else {
            cell.baseStockThree.isHidden = true
        }
        
        return cell
    }
    
    private func success() {
        DispatchQueue.main.async {
            self.baseView.isHidden = self.viewModel.symbols.isEmpty
            self.refreshTitle()
            self.tableView.reloadData()
        }
    }
    
    func refreshTitle() {
        
        let symbols = self.viewModel.symbols
        
        let bases = [self.baseTitleStockOne, self.baseTitleStockTwo, self.baseTitleStockThree]
        let labels = [self.lblTitleStockOne, self.lblTitleStockTwo, self.lblTitleStockThree]
        
        for i in 0..<3 {
            if let symbol = symbols.getElement(at: i) {
                labels[i]!.text = symbol
                bases[i]!.isHidden = false
            } else {
                bases[i]!.isHidden = true
            }
        }
    }
    
}
