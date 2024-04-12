//
//  WeeklyWeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import SwiftUI
import WeatherKit

struct WeeklyWeatherView: View {
    @State var weather : Weather
    @State var viewModel : ContentViewViewModel
    
    var body: some View {
        if let dailyForecast = weather.dailyForecast.first {
            VStack(spacing : 5) {
                Text(viewModel.weatherManager.locationManager.city)
                    .font(.title)
                Text("\(weather.currentWeather.temperature.value.rounded())°")
                Text("\(dailyForecast.highTemperature.value.rounded())°")
                Text("\(dailyForecast.lowTemperature.value.rounded())°")
            }
        }
    }
}

//#Preview {
//    WeeklyWeatherView()
//}
