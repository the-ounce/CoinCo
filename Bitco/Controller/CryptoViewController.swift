//
//  ViewController.swift
//  Bitco
//
//  Created by Никита Гавриленко on 23.06.2022.
//

import UIKit

class CryptoViewController: UIViewController {
    
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
    
    
}

//MARK: - UIPickerView

extension CryptoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Avenir-Heavy", size: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text =  cryptoManager.currencyArray[row]
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cryptoManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = cryptoManager.currencyArray[row]
        cryptoManager.getCoinPrice(for: selectedCurrency)
    }
    
}

//MARK: - CryptoManagerDelegate

extension CryptoViewController: CryptoManagerDelegate {
    
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

