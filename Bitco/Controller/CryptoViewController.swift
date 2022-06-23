//
//  ViewController.swift
//  Bitco
//
//  Created by Никита Гавриленко on 23.06.2022.
//

import UIKit

class CryptoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CryptoManagerDelegate {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var cryptoManager = CryptoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cryptoManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cryptoManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cryptoManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = cryptoManager.currencyArray[row]
        cryptoManager.getCoinPrice(for: selectedCurrency)
    }
    
    func didUpdateRateInfo(_ cryptoRateInfo: CryptoModel) {
        
        DispatchQueue.main.async {
            self.priceLabel.text = cryptoRateInfo.stringPrice
            self.currencyLabel.text = cryptoRateInfo.currency
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

