//
//  SearchBar.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/6/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var keyword: String

    var body: some View {
        HStack {
            TextField("Search for images", text: $keyword)
                .padding()
                .foregroundStyle(.secondary)

            if !keyword.isEmpty {
                Button("", systemImage: "xmark.circle.fill") {
                    keyword = ""
                }
                .foregroundStyle(.secondary)
                .padding(.trailing, 5)
            }
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
    }
}

#Preview {
    SearchBar(keyword: .constant(""))
        .padding()
}
