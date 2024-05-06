//
//  ContentViewViewModel.swift
//  WeatherApp
//
//  Created by 정현 on 4/12/24.
//

import SwiftUI
import Combine

class ContentViewViewModel : ObservableObject {
    @Published var weatherManager = WeatherManager()
    
    private var anyCancellable: AnyCancellable? = nil
    init() {
        anyCancellable = weatherManager.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
    }
}
