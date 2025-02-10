//
//  CachedImageView.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import SwiftUI

struct CachedImageView: View {
    @State var viewModel: CachedImageViewModel

    init(imageURLString: String, postId: String) {
        _viewModel = State(initialValue: CachedImageViewModel(imageURLString: imageURLString, postId: postId))
    }

    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(10)
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.loadImage()
        }
    }
}

#Preview {
    CachedImageView(
        imageURLString: "https://live.staticflickr.com/65535/54074976642_b17890fe61_m.jpg",
        postId: UUID().uuidString
    )
}
