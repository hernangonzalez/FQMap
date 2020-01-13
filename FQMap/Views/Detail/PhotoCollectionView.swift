//
//  PhotoCollectionView.swift
//  FQMap
//
//  Created by Hernan G. Gonzalez on 13/01/2020.
//  Copyright © 2020 Hernan. All rights reserved.
//

import SwiftUI

struct PhotoCollectionView: View {
    let photos: [VenuePhotoViewModel]

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.white
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(self.photos) {
                            PhotoView(url: $0.url)
                                .frame(width: self.itemWidth(from: proxy.size),
                                       height: proxy.size.height)
                        }
                    }
                }
            }
        }
    }


    private func itemWidth(from size: CGSize) -> CGFloat {
        photos.count > 1 ? size.height : size.width
    }
}

private struct PhotoView: View {
    let url: URL

    var body: some View {
        RemoteImage(url: url)
            .background(Color.gray)
    }
}

#if DEBUG
struct Collection_Previews : PreviewProvider {
    static let model: [VenuePhotoViewModel] = [
        .init(id: "", url: URL(fileURLWithPath: ".")),
        .init(id: "", url: URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/0e/cc/0a/dc/restaurant-chocolat.jpg")!),
        .init(id: "", url: URL(string: "https://smakelijk.nl/breda/wp-content/uploads/sites/2/2016/03/chocolat-breda-restaurant-6.jpg")!)
    ]

    static var previews: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            PhotoCollectionView(photos: model)
                .frame(height: 240)
        }
    }
}
#endif
