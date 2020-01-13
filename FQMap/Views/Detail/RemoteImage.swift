//
//  RemoteImage.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 13/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import Foundation
import Kingfisher
import SwiftUI

struct RemoteImage {
    let url: URL
}

extension RemoteImage: UIViewRepresentable {
    func makeUIView(context: Context) -> UIImageView {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }

    func updateUIView(_ view: UIImageView, context: Context) {
        view.kf.setImage(with: url, options: [.transition(.fade(0.35))])
    }
}
