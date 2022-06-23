//
//  CryptoModel.swift
//  Bitco
//
//  Created by Никита Гавриленко on 23.06.2022.
//

import Foundation


struct CryptoModel {
    var coin: String
    var currency: String
    var price: Double
    
    var stringPrice: String {
        return String(format: "%.2f", price)
    }
}
