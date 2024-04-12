//
//  CelciusFormatter.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import Foundation

extension Double {
    func roundCelcius() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return "\(String(formatter.string(from: number) ?? ""))°"
    }
}

