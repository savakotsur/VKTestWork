//
//  FetchRepositoriesUseCase.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import Combine

class FetchRepositoriesUseCase {
    private let repository: RepositoryProtocol

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int) -> AnyPublisher<[RepositoryEntity], Error> {
        return repository.fetchRepositories(page: page)
            .eraseToAnyPublisher()
    }
}
