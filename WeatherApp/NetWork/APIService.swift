//
//  APIService.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import Foundation

enum API {
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    static let apiKey = "" //To obtain the API Key, sign in to https://openweathermap.org/.
}

enum Endpoint {
    case weather(latitude: String, longitude: String)
    case cityWeather(cityName: String)
    
    var path: String {
        switch self {
        case .weather(let latitude, let longitude):
            return "/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API.apiKey)&units=metric"
        case .cityWeather(let cityName):
            return "/weather?q=\(cityName)&appid=\(API.apiKey)&units=metric"
        }
    }
    
    var url: URL {
        let urlString = API.baseURL + path
        return URL(string: urlString)!
    }
    
    var httpMethod: String {
        switch self {
        case .weather:
            return "GET"
        case .cityWeather:
            return "GET"
        }
    }
}
