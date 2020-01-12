//
//  VenueView.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 12/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import SwiftUI

struct VenueView: View {
    let viewModel: VenueViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground)
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationBarTitle(viewModel.title)
        }
    }
}

#if DEBUG
struct VenueView_Previews: PreviewProvider {
    static let model = VenueViewModel(title: "What a place!")

    static var previews: some View {
        VenueView(viewModel: model)
    }
}
#endif
