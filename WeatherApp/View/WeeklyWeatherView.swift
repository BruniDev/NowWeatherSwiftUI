//
//  WeeklyWeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import SwiftUI
import WeatherKit

struct WeeklyWeatherView: View {
    @State var weather: Weather
    var weatherUtils : WeatherUtils
    
    var body: some View {
        VStack{
            ForEach(weather.dailyForecast,id: \.date){ dailyForecast in
                HStack {
                    Text(dayFormatter(date: dailyForecast.date))
                    WeatherUtils.getWeatherIcon(condition: dailyForecast.condition.description)
                    Text(dailyForecast.highTemperature.value.roundCelcius())
                    Text(dailyForecast.lowTemperature.value.roundCelcius())
                }
            }
        }
    }
}

//#Preview {
//    WeeklyWeatherView()
//}
