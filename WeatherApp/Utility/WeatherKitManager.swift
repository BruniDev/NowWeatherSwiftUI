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
    
    var temp : Double {
        let temp =
        weather?.currentWeather.temperature
        
        let convert = temp?.converted(to: .celsius).value.rounded()
        return convert ?? 0
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
    
    var hourlyForecast : [HourWeather] {
        var forecast = [HourWeather]()
        weather?.hourlyForecast.forecast.forEach{
            if self.isSameHourOrLater(date1: $0.date, date2: Date()){
                forecast.append(HourWeather(temperature: "\($0.temperature.formatted().dropLast())",symbolName: $0.symbolName,time: self.hourFormatter(date: $0.date)))
            }
        }
        return forecast
    }
    
    
    
    
    var highestTemp : Double {
        let temp = weather?.dailyForecast[0].highTemperature
        let convert = temp?.converted(to: .celsius).value.rounded()
        return convert ?? 0
    }
    
    var lowestTemp : Double {
        let temp = weather?.dailyForecast[0].lowTemperature
        let convert = temp?.converted(to: .celsius).value.rounded()
        return convert ?? 0
    }
    
    func isSameHourOrLater(date1 : Date, date2 : Date) -> Bool {
        let calendar = Calendar.current
        let comparisonResult = calendar.compare(date1,to:date2,toGranularity: .hour)
        
        return comparisonResult == .orderedSame || comparisonResult == .orderedDescending
    }
    
    func hourFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        
        let calendar = Calendar.current
        
        let inputDataComponent = calendar.dateComponents([.day,.hour], from: date)
        let currentDataComponents = calendar.dateComponents([.day,.hour], from: Date())
        
        if inputDataComponent == currentDataComponents {
            return "now"
        } else {
            return dateFormatter.string(from: date)
        }
    }

}

struct HourWeather  : Hashable{
    let temperature : String
    let symbolName : String
    let time : String
}
