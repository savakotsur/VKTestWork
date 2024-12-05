//
//  GitHubRepository.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import Combine

final class GitHubRepository: RepositoryProtocol {
    private let apiService: GitHubAPIService
    
    init(apiService: GitHubAPIService) {
        self.apiService = apiService
    }
    
    func fetchRepositories(page: Int) -> AnyPublisher<[RepositoryEntity], Error> {
        return apiService.fetchRepositories(page: page)
            .map { response in
                response.items.map { item in
                    GitHubRepositoryMapper.mapToDomain(githubItem: item)
                }
            }
            .eraseToAnyPublisher()
    }
}
