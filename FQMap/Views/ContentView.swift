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

    private var findMeButton: some View {
        CircleButton(symbol: .locationFill, action: viewModel.findUser)
            .padding(16)
    }

    var body: some View {
        ZStack {
            AppleMapView(selection: $viewModel.selection,
                         viewport: $viewModel.searchRegion,
                         focusOnUser: $viewModel.focusOnUser,
                         viewModel: viewModel.map)
                .edgesIgnoringSafeArea(.all)
                .overlay(findMeButton, alignment: .bottomTrailing)
        }
        .onAppear(perform: viewModel.findUser)
        .sheet(isPresented: $viewModel.presentDetail) {
            VenueView(viewModel: self.viewModel.venueDetail)
        }
        .alert(isPresented: $viewModel.presentError) {
            Alert(title: Text("Oh no!"),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

