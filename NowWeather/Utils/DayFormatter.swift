//
//  DayFormatter.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import Foundation

func dayFormatter(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "E MM.dd"
    
    return dateFormatter.string(from: date)
}

func hourFormatter(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "a h시"
    
    return dateFormatter.string(from: date)
    
}
