//
//  ContentViewModel.swift
//  ByteCoinUI
//
//  Created by 赤尾浩史 on 2025/02/20.
//

import Foundation
import SwiftUI

class ContentViewModel{
    
    var coinManager = CoinManager()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }  
  
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
