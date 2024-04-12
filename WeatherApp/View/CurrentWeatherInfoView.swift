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
                    Text(weather.currentWeather.temperature.value.roundCelcius())
                    HStack(spacing: 10){
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
