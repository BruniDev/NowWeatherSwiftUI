//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import Foundation
import WeatherKit
import CoreLocation
import SwiftUI
import Combine
import WidgetKit

public class WeatherManager : ObservableObject {
    @Published var weather: Weather?
    @Published var locationManager = LocationManager()
    
    private var anyCancellable : AnyCancellable? = nil
    
    init() {
        anyCancellable = locationManager.objectWillChange.sink{[weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    var shortenedHourWeather: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) > 0
            }.prefix(24))
        } else {
            return []
        }
    }
    
    func requestWeatherForCurrentLocation() async {
        guard let userLocation = locationManager.userLocation else {
            return }
        do {
            weather = try await WeatherService.shared.weather(for: userLocation)
            let weatherDefault = UserDefaults(suiteName: "group.com.brunidev.weatherWhat")
            weatherDefault?.set(weather?.dailyForecast.first?.highTemperature.value.roundCelcius(), forKey: "highTemp")
            weatherDefault?.set(weather?.dailyForecast.first?.lowTemperature.value.roundCelcius() , forKey: "lowTemp")
            weatherDefault?.set(weather?.currentWeather.temperature.value.roundCelcius() , forKey: "temp")
            weatherDefault?.set(weather?.currentWeather.condition.description, forKey: "condition")
            weatherDefault?.set(weather?.dailyForecast[1].highTemperature,forKey: "tomorrowHighTemp")
            weatherDefault?.set(weather?.dailyForecast[1].lowTemperature,forKey: "tomorrowLowTemp")
            weatherDefault?.set(weather?.dailyForecast[1].condition,forKey: "tomorrowCondition")
        
            
        } catch {
            print("\(error.localizedDescription)")
            weather = nil
        }
    }
    
//    func requestWeatherForCurrentLocationinWidget() async -> Weather?{
//        print("Enter")
//        guard let userLocation = locationManager.userLocation else {return nil}
//        do {
//            return try await WeatherService.shared.weather(for: userLocation)
//        } catch {
//            print("Error: \(error.localizedDescription)")
//        }
//        return nil
//    }
    
    
}
