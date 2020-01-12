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

    var body: some View {
        ZStack {
            AppleMapView(selection: $viewModel.selection,
                         viewport: $viewModel.searchRegion,
                         viewModel: viewModel.map)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear(perform: viewModel.viewDidAppear)
        .sheet(isPresented: $viewModel.presentDetail) {
            VenueView(viewModel: self.viewModel.venueDetail)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
