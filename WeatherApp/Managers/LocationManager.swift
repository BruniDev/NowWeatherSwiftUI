//
//  LocationManager.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var city: String = ""
    
    private let locationManager = CLLocationManager()
    private var isLocationManagerAuthorised: Bool = false
    var userLocation : CLLocation?
    
    @Published var authorizationStatus : CLAuthorizationStatus?
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCityforCurrentLocation(completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        guard let userLocation = userLocation else { return }
        CLGeocoder().reverseGeocodeLocation(userLocation) { placemarks, error in
            if let placemark = placemarks?.first {
                let address = placemark.address!
                completion(address,error)
            }
        }
    }

    func requestUserLocation(){
        guard isLocationManagerAuthorised else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        userLocation = locations.first
        locationManager.stopUpdatingLocation() // 배터리 줄여주는 용도
        
        getCityforCurrentLocation { [weak self] city, error in
            guard error == nil else { return }
            self?.city = city ?? "Unknown City"
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error location \(error.localizedDescription)")
    }
    
        // MARK: - 위치정보관련
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            isLocationManagerAuthorised = true
        case .authorizedWhenInUse:
            isLocationManagerAuthorised = true
        case .denied :
            isLocationManagerAuthorised = false
        case .notDetermined :
            isLocationManagerAuthorised = false
        case .restricted :
            isLocationManagerAuthorised = false
            
        @unknown default:
            fatalError("Location Manager error")
        }
    }
    
}


extension CLPlacemark {
    var address: String? {
            var result = ""
            if let city = administrativeArea {
                if city == "서울특별시" {
                    result += ""
                }else{
                    result += "\(city)"
                }
            }
        if let city = locality {
            result += " \(city)"
            if city == "서울특별시"
            {
                if let dong = subLocality {
                    result += " \(dong)"
                }
            }
        }
            return result
    }
}
