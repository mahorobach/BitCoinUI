//
//  ContentView.swift
//  ByteCoinUI
//
//  Created by 赤尾浩史 on 2025/02/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCurrency = "USD"
    @State private var bitcoinPrice: Double = 0.0
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    let coinManager = CoinManager()
    
    var body: some View {
        ZStack {
            Color(.systemCyan)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("ByteCoin")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                
                ZStack {
                    Color(.systemGreen)
                        .cornerRadius(30)
                    
                    HStack {
                        Image(systemName:"bitcoinsign.circle.fill")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 50, weight: .bold))
                        
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                        } else {
                            Text(String(format: "%.2f", bitcoinPrice))
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Text(selectedCurrency)
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                }
                .frame(height: 80)
                .padding(.horizontal)
                
                Spacer()
                
                // 通貨選択ピッカー
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(coinManager.currencyArray, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(.wheel)
                .padding(.bottom)
                .onChange(of: selectedCurrency) { oldValue, newValue in
                    Task {
                        await fetchBitcoinPrice()
                    }
                }
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
        .task {
            await fetchBitcoinPrice()
        }
    }
    
    private func fetchBitcoinPrice() async {
        isLoading = true
        do {
            let result = try await coinManager.getCoinPrice(for: selectedCurrency)
            bitcoinPrice = result.price
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        isLoading = false
    }
}

#Preview {
    ContentView()
}
