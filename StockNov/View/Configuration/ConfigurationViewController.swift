//
//  ConfigurationViewController.swift
//  StockNov
//
//  Created by Aditya Haryanov on 25/10/20.
//

import Foundation
import UIKit

class ConfigurationViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let viewModel = ConfigurationViewModel()
    
    //IBOutlets
    @IBOutlet weak var txtApiKey: UITextField!
    @IBOutlet weak var segmentOuputSize: UISegmentedControl!
    
    @IBOutlet weak var pickerViewInterval: UIPickerView!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.pickerViewInterval.delegate = self
        self.pickerViewInterval.dataSource = self
        
        self.txtApiKey.text = viewModel.apiKey
        self.segmentOuputSize.selectedSegmentIndex = (viewModel.selectedOutputSize - 1)
        self.pickerViewInterval.selectRow(viewModel.selectedInterval, inComponent: 0, animated: false)
        
        self.btnSave.addTarget(self, action: #selector(saveConfig), for: .touchUpInside)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.intervals.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.intervals[row]
    }
    
    @objc func saveConfig() {
        
        let newApiKey = txtApiKey.text
        let newOutputSize = OutputSize(rawValue: self.segmentOuputSize.selectedSegmentIndex + 1)
        let newInterval = self.pickerViewInterval.selectedRow(inComponent: 0)
        
        App.userDefault.outputSize = newOutputSize
        App.userDefault.interval = viewModel.intervals[newInterval]
        
        if let apiKey = newApiKey {
            let result = App.keyChain.updateApiKey(newApiKey: apiKey)
            
            if !result {
                self.showErrorAlert(message: "Update API Key Failed")
            } else {
                print("apaiKey = \(App.apiKey)")
            }
        }
        
        self.showSuccessAlert()
    }
    
    func showSuccessAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Configuration updated.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
