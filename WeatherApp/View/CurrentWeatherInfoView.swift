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
         
            VStack(alignment:.leading, spacing: 5) {
                    Text(weather.currentWeather.temperature.value.roundCelcius())
                        .font(.custom("Pretendard-Bold", size: 70))
                    HStack(spacing: 3){
                        Image(systemName: "arrowtriangle.up.fill")
                        Text(dailyForecast.highTemperature.value.roundCelcius())
                            .font(.custom("Pretendard-SemiBold", size: 20))
                            .padding(.trailing,2)
                        Image(systemName: "arrowtriangle.down.fill")
                        Text(dailyForecast.lowTemperature.value.roundCelcius())
                            .font(.custom("Pretendard-SemiBold", size: 20))
                       
                    }
                }
            }
        }
    }


//#Preview {
//    WeeklyWeatherView()
//}
