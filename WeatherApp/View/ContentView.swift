//
//  ContentView.swift
//  WeatherApp
//
//  Created by 정현 on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var isLaunching: Bool = true
    var body: some View {
        if isLaunching{
            LoadingView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLaunching = false
                    }}
        }else{
            WeatherView()
        }
    }
}

#Preview {
    ContentView()
}

