//
//  WeatherKitManager.swift
//  WeatherApp
//
//  Created by 정현 on 3/18/24.
//

import Foundation
import WeatherKit
import SwiftUI
import WidgetKit

@MainActor class WeatherKitManager : ObservableObject {
@Published var weather : Weather?
    var userDefaults = UserDefaults.shared
    
    func getWeather(latitude : Double, longtitude : Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longtitude))
            }.value
            UserDefaults.shared.set("ddd", forKey: "weather")
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
           userDefaults.set(convert, forKey: "nowTemperature")
           userDefaults.synchronize()
           WidgetCenter.shared.reloadAllTimelines()
        return convert ?? 0
    }
    
     
    var weatherCondition : String {
        let weatherCondition = weather?.currentWeather.condition.description

           userDefaults.set(weatherCondition, forKey: "weatherCondition")
           userDefaults.synchronize()
           WidgetCenter.shared.reloadAllTimelines()
        return weatherCondition ?? " "
    }
    
    var hourlyForecast : [HourWeather] {
        var forecast = [HourWeather]()
        guard let date1 = Calendar.current.date(byAdding: .hour, value: 12, to: Date()) else { return forecast }
        weather?.hourlyForecast.forecast.forEach{
            if self.afterHour(date1: $0.date, date2: Date()) && $0.date < date1 {
                forecast.append(HourWeather(temperature: "\(Int($0.temperature.converted(to: .celsius).value.rounded()))",symbolName: $0.symbolName,time: self.hourFormatter(date: $0.date)))
              
            }
        }
        return forecast
    }
    
    var dailyForecast : [DailyWeather] {
        var forecast = [DailyWeather]()
        weather?.dailyForecast.forecast.forEach{
            if self.afterToday(date1: $0.date, date2: Date()){
                forecast.append(DailyWeather(highTemperature: "\(Int($0.highTemperature.converted(to: .celsius).value.rounded()))", lowTemperature: "\(Int($0.lowTemperature.converted(to: .celsius).value.rounded()))", time: self.dayFormatter(date: $0.date), symbolName:  $0.symbolName))
            }
        }
        return forecast
    }
    
    var highestTemp : Double {
        let temp = weather?.dailyForecast[0].highTemperature
        let convert = temp?.converted(to: .celsius).value.rounded()
           userDefaults.set(convert, forKey: "highTemp")
           userDefaults.synchronize()
           WidgetCenter.shared.reloadAllTimelines()

        return convert ?? 0
    }
    
    var lowestTemp : Double {
        let temp = weather?.dailyForecast[0].lowTemperature
        let convert = temp?.converted(to: .celsius).value.rounded()
           userDefaults.set(convert, forKey: "lowTemp")
           userDefaults.synchronize()
           WidgetCenter.shared.reloadAllTimelines()
        return convert ?? 0
    }
    
    func afterToday(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let comparisonResult = calendar.compare(date1,to:date2,toGranularity: .day)
        
        return comparisonResult == .orderedDescending
    }
    func afterHour(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let comparisonResult = calendar.compare(date1,to:date2,toGranularity: .hour)
        
        return comparisonResult == .orderedDescending
    }
    func hourFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a h시"
    
        return dateFormatter.string(from: date)
     
    }
    
    func dayFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date)
    }
    
}

struct HourWeather  : Hashable{
    let temperature : String
    let symbolName : String
    let time : String
}

struct DailyWeather : Hashable {
    let highTemperature : String
    let lowTemperature : String
    let time : String
    let symbolName : String
    
}

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.com.brunidev.weatherWhat"
        return UserDefaults(suiteName: appGroupId)!
    }
}
