//
//  Extension.swift
//  UIKitBasics
//
//  Created by Tarun Sharma on 22/02/26.
//

import Foundation

extension Double {
    
    func abbreviated() -> String {
        let absValue = abs(self)
        let sign = self < 0 ? "-" : ""
        
        switch absValue {
        case 1_000_000_000_000...:
            return "\(sign)\(String(format: "%.2f", absValue / 1_000_000_000_000))Tr"
        case 1_000_000_000...:
            return "\(sign)\(String(format: "%.2f", absValue / 1_000_000_000))Bn"
        case 1_000_000...:
            return "\(sign)\(String(format: "%.2f", absValue / 1_000_000))M"
        case 1_000...:
            return "\(sign)\(String(format: "%.2f", absValue / 1_000))K"
        default:
            return "\(sign)\(String(format: "%.2f", absValue))"
        }
    }
    
    func formatted() -> String {
        return String(format: "%.2f", self)
    }
}
