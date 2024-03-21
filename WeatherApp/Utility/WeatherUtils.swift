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
        if condition == "cloud" || condition == "cloud.moon" || condition == "Cloudy"{
           return Image("cloud_icon")
         } else if condition == "cloud.rain" || condition == "rain" || condition == "cloud.moon.rain"{
           return Image("rain_icon")
         } else if condition == "wind" {
           return Image("wind_icon")
         } else if condition == "moon" {
             return Image("moon_icon")
         }
        else if condition == "snow" {
            return Image("snow_icon")
        }
        else {
             return Image("sunny_icon")
         }
       }
}
