//
//  TodayWeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import SwiftUI
import WeatherKit

struct CurrentWeatherHourlyView: View {
    @State var weather : Weather
    @State var viewModel : ContentViewViewModel
    var weatherUtils : WeatherUtils
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(viewModel.weatherManager.shortenedHourWeather ,id: \.date){ hourForecast in
                    VStack{
                        Text(hourFormatter(date: hourForecast.date))
                            .font(.custom("Pretendard-SemiBold", size: 15))
                            .padding(.bottom,10)
                        WeatherUtils.getWeatherIcon(condition: hourForecast.condition.description)
                        Text(hourForecast.temperature.value.roundCelcius())
                            .font(.custom("Pretendard-Medium", size: 20))
                    }
                    .padding(.leading,10)
                }
            }
        }
        .scrollIndicators(.hidden)
       
    }
}

//#Preview {
//    TodayWeatherView()
//}
