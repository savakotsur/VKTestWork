//
//  MockRepository.swift
//  VKTestWorkTests
//
//  Created by Савелий Коцур on 05.12.2024.
//
import XCTest
import Combine
@testable import VKTestWork


final class MockRepository: RepositoryProtocol {
    var shouldReturnError = false

    func fetchRepositories(page: Int) -> AnyPublisher<[RepositoryEntity], Error> {
        if shouldReturnError {
            return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        } else {
            let mockRepository = RepositoryEntity(id: 1, name: "Repo1", description: "Description", stars: 5, url: "url.com")
            return Just([mockRepository])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
