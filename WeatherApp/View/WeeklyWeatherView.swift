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
                        .font(.custom("Pretendard-Regular", size: 20))
                    Spacer()
                    WeatherUtils.getWeatherIcon(condition: dailyForecast.condition.description)
                    Spacer()
                    Text(dailyForecast.condition.description)

                    Text(dailyForecast.highTemperature.value.roundCelcius())
                        .font(.custom("Pretendard-Regular", size: 20))
                    Text("|")
                    Text(dailyForecast.lowTemperature.value.roundCelcius())
                        .font(.custom("Pretendard-Regular", size: 20))
                        .opacity(0.5)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}

//#Preview {
//    WeeklyWeatherView()
//}
