//
//  TodayWeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import SwiftUI
import WeatherKit

struct TodayWeatherView: View {
    @State var weather : Weather
    @State var viewModel : ContentViewViewModel
    var weatherUtils : WeatherUtils
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(viewModel.weatherManager.shortenedHourWeather ,id: \.date){ hourForecast in
                    VStack(spacing: 15) {
                        Text("\(Int(hourForecast.temperature.value))")
                        WeatherUtils.getWeatherIcon(condition: hourForecast.condition.description)
//                        Text("\(hourForecast.condition.description)")
                        Text(hourFormatter(date: hourForecast.date))
                    }
                }
            }
        }
        .padding(.top,350)
    }
}

//#Preview {
//    TodayWeatherView()
//}
