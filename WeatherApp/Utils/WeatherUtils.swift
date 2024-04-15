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
    
    
  
}
