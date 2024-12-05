//
//  GitHubRepositoryItem.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

struct GitHubRepositoryItem: Decodable {
    let id: Int
    let name: String
    let description: String?
    let starsCount: Int
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case starsCount = "stargazers_count"
        case htmlUrl = "html_url"
    }
}
