//
//  LoadingView.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ProgressView()
                    .tint(Color.indigo)
                Text("Loading data...")
            }//: VStack
        }//: Zstack
    }
}

#Preview {
    LoadingView()
}
