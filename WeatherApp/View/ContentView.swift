//
//  ContentView.swift
//  WeatherApp
//
//  Created by 정현 on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    

    @StateObject var viewModel: WeatherInfoViewModel = WeatherInfoViewModel(
        webservice: NetworkService()
    )

    var body: some View {
            WeatherView(viewModel: viewModel)
        }
}

#Preview {
    ContentView()
}
