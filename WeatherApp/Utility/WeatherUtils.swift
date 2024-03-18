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
     if condition == "Mostly Cloudy" || condition == "partlyCloudy" || condition == "cloudy"{
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
