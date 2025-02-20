//
//  CoinManager.swift
//  ByteCoinUI
//
//  Created by 赤尾浩史 on 2025/02/20.
//

import Foundation
import SwiftUI

protocol CoinManagerDelegate : AnyObject{
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    
    weak var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = Keys.coinApiKey
    
  //  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencyArray = ["AUD", "CAD","EUR","GBP","HKD","JPY","MXN","NOK","NZD","RUB","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) async throws ->  (price: Double, currency: String){
        //1.Create a URL
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw (URLError(.badURL))
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
  
        let decodeData = try JSONDecoder().decode(CoinData.self, from: data)
        return (decodeData.rate, currency)
   
        /*
        // レスポンスの内容をデバッグ出力
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("API Response: \(jsonString)")
                }
                
                // HTTPレスポンスのステータスコードを確認
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: \(httpResponse.statusCode)")
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(CoinData.self, from: data)
                    return (decodedData.rate, currency)
                } catch {
                    print("Decoding error: \(error)")
                    throw error
                }
        */
    }
    
   
    
}






extension CoinManager {
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
