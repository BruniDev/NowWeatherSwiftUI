//
//  WeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherView: View {
    
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @StateObject var locationManager = LocationManager()
    @State var locationTitle = ""
    var weatherUtils = WeatherUtils()
    
    var body: some View {
        GeometryReader{ geometryReader in
            ZStack {
                WeatherUtils.getWeatherBackground(condition: weatherKitManager.weatherCondition)
                    .resizable()
                    .ignoresSafeArea()
                if locationManager.authorizationStatus == .authorizedWhenInUse {
                    VStack(alignment: .leading){
                        Text(" ")
                            .task {
                                self.locationManager.reverseGeocoding(latitude: locationManager.latitude, longitude: locationManager.longtitude) {address in
                                    print(address)
                                    self.locationTitle = address
                                }
                                    await weatherKitManager.getWeather(latitude: locationManager.latitude, longtitude: locationManager.longtitude)
                                }
                        Text(locationTitle)
                                .position(x:geometryReader.size.width/3,y:geometryReader.size.height/10)
                                .font(.system(size: 35,weight: .bold))
                        VStack{
                            Text("\(Int(weatherKitManager.temp))")
                                .font(.system(size: 75,weight: .bold))
                            
                            Text("\(Image(systemName: "arrowtriangle.up.fill"))\(Int(weatherKitManager.highestTemp))    \(Int(weatherKitManager.lowestTemp))\(Image(systemName: "arrowtriangle.down.fill"))")
                                .font(.system(size: 20,weight: .semibold))
                            
                        }
                        .position(x:geometryReader.size.width/6 * 5,y: -geometryReader.size.height/6)
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(weatherKitManager.hourlyForecast,id: \.time){ condition in
                                    VStack{
                                        Text(condition.time)
                                            .font(.system(size: 20,weight: .semibold))
                                        WeatherUtils.getWeatherIcon(condition: condition.symbolName)
//                                        Text(condition.symbolName)
                                            .padding(1)
                                        Text("\(condition.temperature)°")
                                            .font(.system(size: 20,weight: .semibold))
                                            .padding(1)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
                else {
                    Text("Error")
                }
                
                
                
            }
            
        }
    }
}
