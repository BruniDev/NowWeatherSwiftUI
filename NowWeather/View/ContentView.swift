//
//  ContentView.swift
//  WeatherApp
//
//  Created by 정현 on 3/12/24.
//

import SwiftUI
import Combine
import WeatherKit

struct ContentView: View {
    @EnvironmentObject var viewModel : ContentViewViewModel
    let weatherUtils = WeatherUtils()
    var body : some View {
        VStack{
            if let weather = viewModel.weatherManager.weather {
                ScrollView {
                    VStack {
                        Spacer(minLength: 100)
                        HStack{
                            CurrentLocationView(weather: weather, viewModel: viewModel)
                                .padding(.leading,40)
                            Spacer()
                        }
                        Spacer(minLength: 50)
                        HStack{
                            Spacer()
                            CurrentWeatherInfoView(weather: weather, viewModel: viewModel)
                                .padding(.trailing,30)
                            
                        }
                        
                        Spacer(minLength: 400)
                        CurrentWeatherHourlyView(weather: weather , viewModel: viewModel,weatherUtils: WeatherUtils())
                        WeeklyWeatherView(weather: weather,weatherUtils: WeatherUtils())
                    }
                }
                .refreshable {
                    await viewModel.weatherManager.requestWeatherForCurrentLocation()
                }
                .ignoresSafeArea(.all)
                .background {
                    WeatherUtils.getWeatherBackground(condition: weather.currentWeather.condition.description)
                        .resizable()
                        .ignoresSafeArea()
                }
                .scrollIndicators(.hidden)
                
            }
          
        }
        .task {
            morningSetNotification()
            nightSetNotification()
        }
        
    }

    func morningSetNotification() {
        if let defaults = UserDefaults(suiteName: "group.com.brunidev.weatherWhat") {
            let manager = NotificationManager()
            manager.requestPermission()
            manager.addNotification(title: weatherUtils.weatherLocation(location: defaults.string(forKey: "city") ?? ""), body: "\(weatherUtils.weatherAlert(checkNowOrNot : 1,condition: defaults.string(forKey: "condition") ?? ""))\n\(weatherUtils.weatherHighLow(highTemp: defaults.string(forKey: "highTemp") ?? "", lowTemp: defaults.string(forKey: "lowTemp") ?? ""))")
            manager.scheduleNotifications(1)
        }
    }
    func nightSetNotification() {
        if let defaults = UserDefaults(suiteName: "group.com.brunidev.weatherWhat") {
            let manager = NotificationManager()
            manager.requestPermission()
            manager.addNotification(title: weatherUtils.weatherLocation(location: defaults.string(forKey: "city") ?? ""), body: "\(weatherUtils.weatherAlert(checkNowOrNot : 0,condition: defaults.string(forKey: "tomorrowCondition") ?? ""))\n\(weatherUtils.weatherHighLow(highTemp: defaults.string(forKey: "tomorrowHighTemp") ?? "", lowTemp: defaults.string(forKey: "tomorrowLowTemp") ?? ""))")
            manager.scheduleNotifications(0)
        }
    }
}

//#Preview {
//    ContentView()
//}
//
