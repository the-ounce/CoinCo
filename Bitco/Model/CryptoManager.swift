//
//  CryptoManager.swift
//  Bitco
//
//  Created by Никита Гавриленко on 23.06.2022.
//

import UIKit

protocol CryptoManagerDelegate {
    func didUpdateRateInfo(_ cryptoRateInfo: CryptoModel)
    func didFailWithError(error: Error)
}

struct CryptoManager {
    
    var delegate: CryptoManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E86DBD9C-EA24-433C-B53A-205246451AF4"
    
    let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","SEK","SGD","UAH","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let cryptoRate = self.parseJSON(coinData: safeData) {
                        self.delegate?.didUpdateRateInfo(cryptoRate)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(coinData: Data) -> CryptoModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CryptoData.self, from: coinData)
            
            let coin = decodedData.asset_id_base
            let currency = decodedData.asset_id_quote
            let price = decodedData.rate
            
            let cryptoRate = CryptoModel(coin: coin, currency: currency, price: price)
            
            return cryptoRate
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}

