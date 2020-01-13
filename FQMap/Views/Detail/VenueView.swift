//
//  VenueView.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import SwiftUI

struct VenueView: View {
    @ObservedObject var viewModel: VenueViewModel
    @State private var mapSelection: MapAnnotation? = nil
    @State private var mapRegion: MapRegion = .init()
    @State private var focusOnUser: Bool = false

    private var photoHeight: CGFloat {
        viewModel.photos.isEmpty ? 0 : 240
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading, spacing: 20) {
                    PhotoCollectionView(photos: viewModel.photos)
                        .frame(height: photoHeight)
                        .cornerRadius(8)
                        .shadow(radius: 4)

                    Text(viewModel.description)
                        .font(.body)
                        .foregroundColor(Color(.darkText))

                    VStack(alignment: .leading, spacing: 4) {
                        AppleMapView(selection: $mapSelection,
                                     viewport: $mapRegion,
                                     focusOnUser: $focusOnUser,
                                     viewModel: viewModel.map)
                            .frame(height: 160)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .disabled(true)

                        Text(viewModel.address)
                            .font(.subheadline)
                            .foregroundColor(Color(.darkText))
                    }

                    Spacer()
                }
                .padding(.horizontal, 8)
            }
            .navigationBarTitle(viewModel.title)
            .onAppear(perform: viewModel.updateIfNeeded)
        }
    }
}
