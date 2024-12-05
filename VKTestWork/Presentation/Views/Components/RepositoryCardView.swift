//
//  RepositoryCardView.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import SwiftUI

struct RepositoryCardView: View {
    let repository: RepositoryEntity
    
    var body: some View {
        HStack {
            Image(systemName: "folder.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 50)
                .padding(.horizontal, 10)
            VStack(alignment: .leading, spacing: 5) {
                Text(repository.name)
                    .font(.headline)
                Text(repository.description ?? "No description available")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Stars: \(repository.stars)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color("FirstAccent"))
        .cornerRadius(8)
        .padding(.horizontal, 10)
    }
}
