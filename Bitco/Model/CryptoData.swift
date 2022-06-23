//
//  CryptoModel.swift
//  Bitco
//
//  Created by Никита Гавриленко on 23.06.2022.
//

import Foundation

struct CryptoData: Decodable {
    var asset_id_base: String    // Coin
    var asset_id_quote: String   // Currency
    var rate: Double             // Value
}
