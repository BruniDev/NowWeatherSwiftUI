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
        guard let userLocation = locationManager.userLocation else { return }
        do {
            weather = try await WeatherService.shared.weather(for: userLocation)
        } catch {
            print("\(error.localizedDescription)")
            weather = nil
        }
    }
    
    
}
