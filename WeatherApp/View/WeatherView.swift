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
        ZStack {
            WeatherUtils.getWeatherBackground(condition: weatherKitManager.weatherCondition)
                .resizable()
                .ignoresSafeArea()
                    ScrollView{
                        if locationManager.authorizationStatus == .authorizedWhenInUse {
                    VStack {
                            HStack{
                                VStack{
                                    Text("현재 온도: \(weatherKitManager.temp)")
                                        .task {
                                            await weatherKitManager.getWeather(latitude: locationManager.latitude, longtitude: locationManager.longtitude)
                                        }
                                        .font(.system(size: 50,weight: .semibold))
                                    Text("체감 온도: \(weatherKitManager.realtemp)")
                                        .tint(.black)
                                }
                            
                            VStack{
                              Text("최고기온")
                            }
                        }
                        Text("현재 날씨 상태 : \(weatherKitManager.weatherCondition)")
                        
                        HStack{
                            ForEach(weatherKitManager.hourlyForecast,id: \.self){ condition in
                               Text(condition)
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
