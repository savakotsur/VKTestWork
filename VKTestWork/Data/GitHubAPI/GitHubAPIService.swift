//
//  GitHubAPIService.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import Foundation
import Combine

final class GitHubAPIService {
    private let baseURL = "https://api.github.com/search/repositories"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchRepositories(page: Int) -> AnyPublisher<GitHubAPIResponse, Error> {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "q", value: "language:swift"),
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "100")
        ]
        
        let request = URLRequest(url: components.url!)
        
        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: GitHubAPIResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
