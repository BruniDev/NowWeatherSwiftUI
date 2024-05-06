//
//  WeatherUtils.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import Foundation
import SwiftUI

struct WeatherUtils {
    static func getWeatherBackground(condition: String) -> Image {
     if condition == "Mostly Cloudy" || condition == "Partly Cloudy" || condition == "Cloudy"{
        return Image("cloudy")
      } else if condition == "strongStorms" || condition == "thunderstorms"{
        return Image("storm")
      } else if condition == "snow" {
        return Image("snowy")
      } else {
          return Image("sun")
      }
    }
    
    static func getWeatherIcon(condition: String) -> Image {
        switch condition {
        case "Clear", "Mostly Clear":
            return Image("sunny_icon")
        case "Partly Cloudy" :
            return Image("cloud_sun_icon")
        case "Mostly Cloudy","Cloudy","Foggy":
            return Image("cloud_icon")
        case "Rain" ,"Heavy Rain", "Drizzle" :
            return Image("rain_icon")
        case "Blizzard", "Breezy" ,"Windy" :
            return Image("wind_icon")
        case "blowing Snow","Heavy Snow","Flurries"  :
            return Image("snow_icon")
        default:
            return Image("cloud_icon")
        }
        
        
    }
    func weatherLocation(location : String) -> String {
        return "📍\(location)"
    }
    func weatherAlert(checkNowOrNot : Int,condition : String) -> String {
        let date = checkNowOrNot == 1 ? "오늘" : "내일"
        switch condition {
        case "Clear","Mostly Clear":
           return "\(date)은 화창한 날씨입니다 ☀️"
        case "Partly Cloudy","Mostly Cloudy","Cloudy" :
            return "\(date)은 구름이 많은 날씨입니다 ☁️"
        case "Foggy":
            return "\(date)은 안개가 많은 날씨입니다 😶‍🌫️"
        case "Rain" ,"Heavy Rain","Drizzle" :
            return "\(date)은 비소식이 있습니다 ☔️"
        case "Blizzard","Windy","Breezy" :
            return "\(date)은 바람이 많이 불어요 💨"
        case "blowing Snow","Heavy Snow","Flurries" :
            return "\(date)은 눈소식이 있습니다 ☃️"
        default:
            return "\(date)은 화창한 날씨입니다 ☀️"
        }
    }
    
    func weatherHighLow(highTemp : String, lowTemp : String) -> String {
        return "최고 \(highTemp) 최저 \(lowTemp)"
    }
  
}
