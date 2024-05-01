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
        case "Clear":
            return Image("sunny_icon")
        case "Mostly Clear":
            return Image("sunny_icon")
        case "Partly Cloudy" :
            return Image("cloud_sun")
        case "Mostly Cloudy" :
            return Image("cloud_icon")
        case "Cloudy" :
            return Image("cloud_icon")
        case "Foggy":
            return Image("cloud_icon")
        case "Rain" :
            return Image("rain_icon")
        case "Heavy Rain" :
            return Image("rain_icon")
        case "Drizzle" :
            return Image("rain_icon")
        case "Blizzard" :
            return Image("wind_icon")
        case "Windy" :
            return Image("wind_icon")
        case "Breezy" :
            return Image("wind_icon")
        case "blowing Snow":
            return Image("snow_icon")
        case "Heavy Snow" :
            return Image("rain_icon")
        case "Flurries" :
            return Image("snow_icon")
        default:
            return Image("cloud_icon")
        }
        
        
    }
    
    func weatherAlert(checkNowOrNot : Int,condition : String) -> String {
        let date = checkNowOrNot == 1 ? "오늘" : "내일"
        switch condition {
        case "Clear","Mostly Clear":
           return "\(date)은 화창할 예정입니다 ☀️"
        case "Partly Cloudy","Mostly Cloudy","Cloudy" :
            return "\(date)은 구름이 많이 낄 예정입니다 ☁️"
        case "Foggy":
            return "\(date)은 안개가 많이 낄 예정입니다 😶‍🌫️"
        case "Rain" ,"Heavy Rain","Drizzle" :
            return "\(date)은 비소식이 있습니다 ☔️"
        case "Blizzard","Windy","Breezy" :
            return "\(date)은 바람이 많이 불어요 💨"
        case "blowing Snow","Heavy Snow","Flurries" :
            return "\(date)은 눈소식이 있습니다 ☃️"
        default:
            return "\(date)은 화창할 예정입니다 ☀️"
        }
    }
  
}
