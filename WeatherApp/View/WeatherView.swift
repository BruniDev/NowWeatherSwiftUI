//
//  WeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import SwiftUI
import WeatherKit


struct WeatherView: View {
    
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @State private var showingSheet = false
    @StateObject var locationManager = LocationManager()
    var weatherUtils = WeatherUtils()
    
    var body: some View {
        GeometryReader{ geometryReader in
            ZStack {
                WeatherUtils.getWeatherBackground(condition: weatherKitManager.weatherCondition)
                    .resizable()
                    .ignoresSafeArea()
                if locationManager.authorizationStatus == .authorizedWhenInUse {
                    VStack(alignment: .leading){
                        Text("서울특별시 광진구")
                            .task {
                                await weatherKitManager.getWeather(latitude: locationManager.latitude, longtitude: locationManager.longtitude)
                            }
                            .position(x:geometryReader.size.width/3,y:geometryReader.size.height/10)
                            .font(.system(size: 30,weight: .semibold))
                        
                        
                        
                        VStack{
                            Text("\(Int(weatherKitManager.temp))")
                                .font(.system(size: 75,weight: .bold))
                            
                            Text("\(Image(systemName: "arrowtriangle.up.fill"))\(Int(weatherKitManager.highestTemp))  \(Int(weatherKitManager.lowestTemp))\(Image(systemName: "arrowtriangle.down.fill"))")
                                .font(.system(size: 20,weight: .semibold))
                        }
                        .position(x:geometryReader.size.width/6 * 5,y: -geometryReader.size.height/8)
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(weatherKitManager.hourlyForecast,id: \.time){ condition in
                                    VStack{
                                        Text(condition.temperature)
                                            .font(.system(size: 20,weight: .semibold))
                                            .padding(1)
                                        Image(systemName: condition.symbolName)
                                            .padding(1)
                                        Text(condition.time)
                                            .font(.system(size: 20,weight: .semibold))
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

//#Preview {
//    WeatherView(viewModel: WeatherInfoViewModel())
//}
