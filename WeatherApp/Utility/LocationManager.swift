//
//  LocationManager.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    var userLocation: CLLocation? { get set }
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol, ObservableObject {
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = location
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func requestLocation() {

        locationManager.requestLocation()
    }
}
