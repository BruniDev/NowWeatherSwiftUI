//
//  WeatherUtils.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import Foundation
import SwiftUI

enum weather {
    case blowingDust
    case clear
    case cloudy
    case foggy
    case haze
    case mostlyClear
    case mostlyCloudy
    case partlyCloudy
    case smoky
}
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

}
