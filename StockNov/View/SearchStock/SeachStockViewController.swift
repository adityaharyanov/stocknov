//
//  SeachStockViewController.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation
import UIKit

class SearchStockViewController : UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel = StockSearchViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var completion : ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Find Stock Symbol"
        self.hideKeyboardWhenTappedAround()
        
        self.searchBar.delegate = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let symbol = searchBar.text
        self.viewModel.symbol = symbol ?? ""
        
        fetchStockPairData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.stockPairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StockSearchCell.Id) as! StockSearchCell
        let item = self.viewModel.stockPairs[indexPath.row]
        
        cell.lblTitle.text = item.symbol
        cell.lblDetail.text = item.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.stockPairs[indexPath.row]
        self.completion!(item.symbol)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func fetchStockPairData() {
        viewModel.getStockPairs(completion: success, error: showErrorAlert(message:))
    }
    
    private func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
