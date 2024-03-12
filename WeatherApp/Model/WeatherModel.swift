//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by 정현 on 3/12/24.
//
import Foundation

struct WeatherResponse: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String?
    let main: Main
    let visibility: Int?
    let dt: Int?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Coordinates: Codable {
    let lon: Double?
    let lat: Double?
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Codable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let humidity: Int?
    let sea_level: Int?
    let grnd_level: Int?
}
