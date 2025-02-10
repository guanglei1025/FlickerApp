//
//  PostHomeView.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import SwiftUI

struct PostHomeView: View {

    @State private var searchKeyword: String = ""

    @State var viewModel = PostHomeViewModel()

    private var columns =  Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    var body: some View {
        NavigationStack {
            VStack{
                SearchBar(keyword: $searchKeyword)
                    .padding()
                    .onChange(of: searchKeyword) { oldValue, newValue in
                        if newValue.isEmpty {
                            viewModel.clearPosts()
                        } else {
                            viewModel.search(keyword: newValue)
                        }
                    }

                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.posts) { post in
                            NavigationLink {
                                PostDetailsView(post: post)
                            } label: {
                                CachedImageView(imageURLString: post.imageURLString, postId: post.id.uuidString)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150)
                            }
                        }
                    }
                    .padding()
                }
                .overlay {
                    if viewModel.isSearching {
                        ProgressView()
                    } else if viewModel.posts.isEmpty {
                        ContentUnavailableView("No images to show", systemImage: "photo.on.rectangle.angled")
                    }
                }
            }
        }
    }
}

#Preview {
    PostHomeView()
}
