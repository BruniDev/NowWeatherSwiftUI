//
//  WeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import SwiftUI
import WeatherKit
import CoreLocation
import WidgetKit
struct WeatherView: View {
    
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @StateObject var locationManager = LocationManager()
    var userDefaults = UserDefaults.shared
    @State var locationTitle = ""
    var weatherUtils = WeatherUtils()
    
    var body: some View {
        GeometryReader{ geometryReader in
            ZStack {
                WeatherUtils.getWeatherBackground(condition: weatherKitManager.weatherCondition)
                    .resizable()
                    .ignoresSafeArea()
                if locationManager.authorizationStatus == .authorizedWhenInUse {
                    ScrollView{
                        VStack(alignment: .leading){
                            Text(" ")
                                .task {
                                    self.locationManager.reverseGeocoding(latitude: locationManager.latitude, longitude: locationManager.longtitude) {address in
                                        self.locationTitle = address
                                        
                                        userDefaults.set(address, forKey: "nowLocation")
                                        userDefaults.synchronize()
                                        WidgetCenter.shared.reloadAllTimelines()
                                    }
                                    await weatherKitManager.getWeather(latitude: locationManager.latitude, longtitude: locationManager.longtitude)
                                }
                            Text(locationTitle)
                                .position(x:geometryReader.size.width/3,y:geometryReader.size.height/10)
                                .font(.system(size: 35,weight: .bold))
                            VStack{
                                Text("\(Int(weatherKitManager.temp))°")
                                    .font(.system(size: 75,weight: .bold))
                                
                                Text("\(Image(systemName: "arrowtriangle.up.fill"))\(Int(weatherKitManager.highestTemp))    \(Int(weatherKitManager.lowestTemp))\(Image(systemName: "arrowtriangle.down.fill"))")
                                    .font(.system(size: 20,weight: .semibold))
                                
                            }
                            .position(x:geometryReader.size.width/6 * 5,y: geometryReader.size.height/6)
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
                            .padding(.top,350)
                            ForEach(weatherKitManager.dailyForecast,id: \.time){condition in
                                HStack {
                                    Text(condition.time)
                                        .font(.system(size: 20,weight: .semibold))
                                        .padding(.leading,30)
                                      Spacer()
                                    WeatherUtils.getWeatherIcon(condition: condition.symbolName)
                                        .padding(.leading,30)
                                    
                                    Spacer()
                                    Text("\(condition.highTemperature)°")
                                        .font(.system(size: 24,weight: .semibold))
                                    Text("|")
                                        .font(.system(size: 24,weight: .semibold))
                                        .opacity(0.2)
                                    Text("\(condition.lowTemperature)°")
                                        .font(.system(size: 24,weight: .semibold))
                                        .opacity(0.5)
                                    Spacer()
                                }
                                
                            }
                           
                            .padding(.top,30)
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

#Preview {
    WeatherView()
}
