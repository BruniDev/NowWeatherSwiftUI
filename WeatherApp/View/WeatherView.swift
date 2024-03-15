//
//  WeatherView.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var weatherKitViewModel = WeatherKitViewModel()
    
    @StateObject var viewModel: WeatherInfoViewModel
    @State private var showingSheet = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
            
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Spacer()
                    // MARK: - 도시검색 버튼
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                    }
                    .sheet(isPresented: $showingSheet) {
                        LocationView(cityNameClosure: { cityName in
                            viewModel.getWeather(by: cityName)
                        }, isPresented: $showingSheet)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(200)])
                    }
                }
                .tint(.black)
                
                Spacer()
                
                
                VStack(alignment: .center) {
                    Text("\(weatherKitViewModel.currentTemperature)")
                        .font(.system(size: 100,weight: .bold))
                    Text("\(weatherKitViewModel.currentCondition)")
                        .font(.system(size: 20,weight: .regular))
                    WeatherUtils.getWeatherIcon(condition:viewModel.conditionId)
                        .resizable()
                        .frame(width: 250,height: 200)
                    
                }
                Spacer()
                Text("\(viewModel.name)")
                    .font(.system(size: 60))
            }
            .padding()
            .refreshable {
                viewModel.locationManager.requestLocation()
            } 
        }
    }
}

#Preview {
    WeatherView(viewModel: WeatherInfoViewModel())
}
