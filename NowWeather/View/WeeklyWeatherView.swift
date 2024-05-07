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
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .frame(width : 80)
                    Spacer()
                    WeatherUtils.getWeatherIcon(condition: dailyForecast.condition.description)
                        .resizable()
                        .frame(width: 60,height: 60)
                    Spacer()
                    HStack{
                        Text(dailyForecast.highTemperature.value.roundCelcius())
                            .font(.custom("Pretendard-SemiBold", size: 20))
                        Text("|")
                        Text(dailyForecast.lowTemperature.value.roundCelcius())
                            .font(.custom("Pretendard-SemiBold", size: 20))
                            .opacity(0.5)
                    }
                    .padding(.trailing,5)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom,10)
        .padding(.horizontal)
    }
}

//#Preview {
//    WeeklyWeatherView()
//}
