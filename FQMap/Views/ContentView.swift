//
//  ContentView.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 10/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: ContentViewModel
    @State private var viewport: MapRegion = .init()

    var body: some View {
        ZStack {
            AppleMapView(viewport: $viewModel.searchRegion,
                         viewModel: viewModel.map)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
