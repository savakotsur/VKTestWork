//
//  GitHubAPIResponse.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

struct GitHubAPIResponse: Decodable {
    let items: [GitHubRepositoryItem]
}
