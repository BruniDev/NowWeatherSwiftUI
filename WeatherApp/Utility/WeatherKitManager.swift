//
//  WeatherKitManager.swift
//  WeatherApp
//
//  Created by 정현 on 3/18/24.
//

import Foundation
import WeatherKit

@MainActor class WeatherKitManager : ObservableObject {
    
    @Published var weather : Weather?
    
    func getWeather(latitude : Double, longtitude : Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longtitude))
            }.value
        } catch {
            fatalError("\(error)")
        }
    }
    
    var symbol : String {
        weather?.currentWeather.symbolName ?? "xmark"
    }
    
    var temp : String {
        let temp =
        weather?.currentWeather.temperature
        
        let convert = temp?.converted(to: .celsius).description
        return convert ?? "Loading Weather Data"
    }
    
    var realtemp : String {
        let realTemp = weather?.currentWeather.apparentTemperature
        
        let convert = realTemp?.converted(to: .celsius).description
        return convert ?? "Loading real Weather Data"
    }
    
    var windSpeed : Double {
        let windSpeed = weather?.currentWeather.wind.speed.value
        
        return windSpeed ?? 0.0
        
    }
    
    var weatherCondition : String {
        let weatherCondition = weather?.currentWeather.condition.description
        
        return weatherCondition ?? " "
    }
    
    var uvCondition : Int {
        let uvCondition = weather?.currentWeather.uvIndex.value
        
        return uvCondition ?? 0
    }
    
    var visibility : Double {
        let visibility = weather?.currentWeather.visibility.value
        
        return visibility ?? 0.0
    }
    
    var hourlyForecast : [String] {
        var arr = [String]()
        weather?.dailyForecast.forEach{
            arr.append("날씨 \($0.symbolName), 최고기온 \($0.highTemperature), 최저기온 \($0.lowTemperature)")
        }
        
        return arr
    }
    
 
       
    

}
