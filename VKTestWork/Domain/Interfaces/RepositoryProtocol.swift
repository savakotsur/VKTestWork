//
//  RepositoryProtocol.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import Combine

protocol RepositoryProtocol {
    func fetchRepositories(page: Int) -> AnyPublisher<[RepositoryEntity], Error>
}
