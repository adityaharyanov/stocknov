//
//  IntradayViewCntroller.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation
import UIKit

class IntradayViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel = IntradayViewModel()
    
    //IBOutlets
    @IBOutlet weak var txtSymbol: UITextField!
    @IBOutlet weak var lblLastRefreshed: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFind: UIButton!
    @IBOutlet weak var viewBase: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.lblLastRefreshed.text = ""
        
        self.tableView.rowHeight = 35
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.btnFind.addTarget(self, action: #selector(openStockSearchPage), for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! SearchStockViewController
        
        vc.completion = { symbol in
            self.viewModel.symbol = symbol
            self.txtSymbol.text = symbol
            self.fetchStockData()
        }
        
    }
    
    @objc func openStockSearchPage(){
        performSegue(withIdentifier: "StockSearchSegue", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.stocks.keys.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = Array(self.viewModel.stocks.keys)[section]
        
        let section = tableView.dequeueReusableCell(withIdentifier: IntradayStockCell.sectionId)!
        
        section.textLabel?.text = item
        return section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(viewModel.stocks.values)[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IntradayStockCell.Id) as! IntradayStockCell
        let key = Array(viewModel.stocks.values)[indexPath.section]
        let item = key[indexPath.row]
        
        cell.lblTime.text = item.dateTime?.getTime()
        cell.lblOpen.text = item.open
        cell.lblHigh.text = item.high
        cell.lblLow.text = item.low
        
        return cell
    }
    
    private func fetchStockData() {
        viewModel.getData(completion: success, error: showErrorAlert(message:))
    }
    
    private func success() {
        DispatchQueue.main.async {
            self.viewBase.isHidden = false
            self.lblLastRefreshed.text = self.viewModel.meta?.lastRefreshed?.getDateTime()
            
            self.tableView.reloadData()
        }
    }
}
