//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import SwiftUI
import WeatherKit

struct CurrentWeatherInfoView: View {
    @State var weather : Weather
    @State var viewModel : ContentViewViewModel
    
    var body: some View {
        if let dailyForecast = weather.dailyForecast.first {
         
                VStack(spacing: 5) {
                    Text("\(Int(weather.currentWeather.temperature.value.rounded()))°")
                    HStack(spacing: 10){
                        Text("\(Int(dailyForecast.highTemperature.value.rounded()))°")
                        Text("\(Int(dailyForecast.lowTemperature.value.rounded()))°")
                    }
                }
            }
        }
    }


//#Preview {
//    WeeklyWeatherView()
//}
