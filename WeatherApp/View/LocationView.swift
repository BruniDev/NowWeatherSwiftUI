//
//  LocationVIew.swift
//  WeatherApp
//
//  Created by 정현 on 3/13/24.
//

import SwiftUI

struct LocationView: View {
    
   
    @State private var cityName: String = ""
    var cityNameClosure: (_ cityName: String) -> Void
    @Binding var isPresented: Bool
    

    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack(alignment: .center) {
                
                HStack {
                    Text("")
                        .padding(.horizontal, 8)
                    TextField("Seoul", text: $cityName)
                        .textFieldStyle(.plain)
                }
                .frame(height: 50)
                .background(Color.white)
                .clipShape(.capsule)
                
                Button {
                    if !cityName.isEmpty {
                        cityNameClosure(cityName)
                        isPresented = false
                    }
                } label: {
                    Text("날씨 조회하기")
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 20)
                }
                .buttonStyle(.bordered)
                .tint(.black)
                .clipShape(.capsule)
                .padding(.vertical, 20)
                
                Spacer()
            }
            .padding([.horizontal, .vertical], 24)
        }
    }
}

#Preview {
    LocationView(cityNameClosure: {_ in }, isPresented: .constant(true))
}
