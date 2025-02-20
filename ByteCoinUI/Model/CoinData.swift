//
//  CoinData.swift
//  ByteCoinUI
//
//  Created by 赤尾浩史 on 2025/02/20.
//

import Foundation

/*
struct CoinData: Codable {
    let time : String
    let base : String
    let quote : String
    let rate : Double
}
*/

struct CoinData: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case asset_id_base
        case asset_id_quote
        case rate
    }
}
