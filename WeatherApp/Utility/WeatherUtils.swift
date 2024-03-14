//
//  WeatherUtils.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import Foundation
import SwiftUI

struct WeatherUtils {
    static func getWeatherIcon(condition: Int) -> Image {
     if (condition < 400) {
        return Image("cloud")
      } else if (condition < 600) {
        return Image("rainy")
      } else if (condition < 700) {
        return Image("snowy")
      } else {
          return Image("sunny")
      }
    }

}
