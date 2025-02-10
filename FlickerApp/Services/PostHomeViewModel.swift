//
//  PostHomeViewModel.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import Foundation
import Observation

@Observable
class PostHomeViewModel {
    
    /// Fetched posts
    var posts = [Post]()

    var isSearching: Bool = false

    private let imageService = PostAPIService()

    private var searchTask: Task<Void, Never>?
    
    /// Debounce search
    @MainActor
    func search(keyword: String) {
        guard keyword.count >= 3 else { return }
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000) // Half second
            guard !Task.isCancelled else {
                return
            }
            await fetchPosts(keyword: keyword)
        }
    }

    @MainActor
    private func fetchPosts(keyword: String) async {
        defer {
            isSearching = false
        }
        
        isSearching = true
        do {
            posts =  try await imageService.fetchPosts(keyword: keyword)
        } catch {
            // FIXME: Handle error based on real world requirement (e.g. Show Alert)
            print("Fetch Post failed with error: \(error)")
        }
    }

    func clearPosts() {
        posts.removeAll()
    }
}
