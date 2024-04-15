//
//  LocationView.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import SwiftUI
import WeatherKit

struct CurrentLocationView: View {
    @State var weather : Weather
    @State var viewModel : ContentViewViewModel
    var body: some View {
                VStack(spacing : 5) {
                Text(viewModel.weatherManager.locationManager.city)
                    .font(.custom("Pretendard-Bold", size: 35))
        }
    }
}

//#Preview {
//    LocationView()
//}
