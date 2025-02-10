//
//  PostDetailsView.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import SwiftUI

struct PostDetailsView: View {

    let post: Post

    var body: some View {
        Form {
            Section {
                AsyncImage(url: URL(string: post.media.imageURLString)) { image in
                    image.image?
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }

            Section {
                LabeledContent("Title", value: post.title)
                LabeledContent("Author", value: post.author)
                LabeledContent("Date", value: post.timestampDisplay)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                    Text(post.description)
                        .foregroundStyle(.secondary)
                        .font(.callout)
                }
            }
        }
        .navigationTitle("Details")
    }
}

#Preview {
    PostDetailsView(post: Post.mock())
}
