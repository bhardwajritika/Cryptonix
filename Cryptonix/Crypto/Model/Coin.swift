//
//  Coin.swift
//  UIKitBasics
//
//  Created by Tarun Sharma on 21/02/26.
//

import Foundation

struct Coin: Codable {
    let id, symbol, name: String
    let image: String?
    let currentPrice: Double?
    let marketCap: Double?
    let marketCapRank: Int?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let ath: Double?
    let lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case ath
        case lastUpdated = "last_updated"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id     = try container.decode(String.self, forKey: .id)
        symbol = try container.decode(String.self, forKey: .symbol)
        name   = try container.decode(String.self, forKey: .name)
        image  = try container.decodeIfPresent(String.self, forKey: .image)
        
        // Use decodeIfPresent and provide defaults
        currentPrice = try container.decodeIfPresent(Double.self, forKey: .currentPrice) ?? 0.0
        marketCap    = try container.decodeIfPresent(Double.self, forKey: .marketCap) ?? 0.0
        marketCapRank = try container.decodeIfPresent(Int.self, forKey: .marketCapRank) ?? 0
        totalVolume  = try container.decodeIfPresent(Double.self, forKey: .totalVolume) ?? 0.0
        high24H      = try container.decodeIfPresent(Double.self, forKey: .high24H) ?? 0.0
        low24H       = try container.decodeIfPresent(Double.self, forKey: .low24H) ?? 0.0
        priceChange24H = try container.decodeIfPresent(Double.self, forKey: .priceChange24H) ?? 0.0
        priceChangePercentage24H = try container.decodeIfPresent(Double.self, forKey: .priceChangePercentage24H) ?? 0.0
        marketCapChange24H = try container.decodeIfPresent(Double.self, forKey: .marketCapChange24H) ?? 0.0
        marketCapChangePercentage24H = try container.decodeIfPresent(Double.self, forKey: .marketCapChangePercentage24H) ?? 0.0
        ath = try container.decodeIfPresent(Double.self, forKey: .ath) ?? 0.0
        lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
    }
}
