//
//  File.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class WeatherInfoViewModel: ObservableObject {
    
    // MARK: 변수들
    private var webservice: WeatherServiceProtocol!
    @Published var weatherData: WeatherResponse?
    @ObservedObject var locationManager: LocationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading = true
    
    // MARK: - 초기화
    init(webservice: WeatherServiceProtocol = NetworkService()) {
        self.webservice = webservice
        obserLocationChanges()
    }
    
    // MARK: - 장소 변경
    func obserLocationChanges() {
        // Observe changes to userLocation
        locationManager.$userLocation
            .sink { [weak self] location in
                self?.getCurrentLocationWeather(location)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - 받으려는 정보들
    var temp: Int {
        Int(weatherData?.main.temp ?? 0.0)
    }
    
    var name: String {
        "\(weatherData?.name ?? "")"
    }
    
    var conditionId: Int {
        weatherData?.weather.first?.id ?? 0
    }
}

//MARK: - API 부르는 것
extension WeatherInfoViewModel {
    /// Get Current Location based weather
    func getCurrentLocationWeather(_ location: CLLocation?) {
        guard let userLocation = location else  {return}
        self.isLoading = true
        let latitude = String(userLocation.coordinate.latitude)
        let longitude = String(userLocation.coordinate.longitude)
        
        webservice.getWeather(latitude, longitude) { [weak self] response, error in
            guard let response = response, let self = self else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.weatherData = nil
                }
                return
            }
            DispatchQueue.main.async {
                self.isLoading = false
                self.weatherData = response
            }
        }
    }
    
   // MARK: - 도시이름으로 가지고 오기
    func getWeather(by cityName: String) {
        self.isLoading = true
        webservice.getCityWeather(cityName) { [weak self] response, error in
            guard let response = response, let self = self else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.weatherData = nil
                }
                return
            }
            DispatchQueue.main.async {
                self.isLoading = false
                self.weatherData = response
            }
        }
    }
}
