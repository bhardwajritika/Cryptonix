//
//  MockCoinDataService.swift
//  UIKitBasics
//
//  Created by Tarun Sharma on 21/02/26.
//

import Foundation


let baseURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&x_cg_demo_api_key="

struct MockCoinDataService {
    func fetchCoins() async throws -> [Coin] {
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode([Coin].self, from: MockData.mockJsonData)
        } catch {
            print("❌ Decoding error:", error)
            throw error
        }
    }
}

struct APICall {
    func networkCall() async throws -> [Coin] {
        guard let url = URL(string: baseURL + apiKey) else {
            throw URLError(.badURL)
        }
        print(url)
        
        let (data, response) = try await URLSession
            .shared
            .data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Coin].self, from: data)
    }
}
