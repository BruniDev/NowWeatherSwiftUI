//
//  ContentView.swift
//  WeatherApp
//
//  Created by 정현 on 3/12/24.
//

import SwiftUI
import Combine
import WeatherKit


struct ContentView: View {
   @StateObject private var viewModel = ContentViewViewModel()
    
    var body : some View {
        VStack{
            if let weather = viewModel.weatherManager.weather {
                ScrollView {
                    VStack {
                        CurrentLocationView(weather: weather, viewModel: viewModel)
                        CurrentWeatherInfoView(weather: weather, viewModel: viewModel)
                        CurrentWeatherHourlyView(weather: weather , viewModel: viewModel,weatherUtils: WeatherUtils())
                        WeeklyWeatherView(weather: weather,weatherUtils: WeatherUtils())
                    }
                }
            } else {
                VStack {
                    Spacer()
                    Text("새로고침중....")
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width : 40)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .background{
                Image("sun")
                    .resizable()
                    .scaledToFill()
            
        }
        .task {
            await viewModel.weatherManager.requestWeatherForCurrentLocation()
        }
    }
}

//#Preview {
//    ContentView()
//}
//
