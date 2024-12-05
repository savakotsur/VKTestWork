//
//  GitHubRepositoryTests.swift
//  VKTestWorkTests
//
//  Created by Савелий Коцур on 05.12.2024.
//

import XCTest
import Combine
@testable import VKTestWork

final class GitHubRepositoryTests: XCTestCase {
    var gitHubRepository: GitHubRepository!
    var mockAPIService: GitHubAPIService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockAPIService = GitHubAPIService(session: URLSession.shared)
        gitHubRepository = GitHubRepository(apiService: mockAPIService)
        cancellables = []
    }

    func testFetchRepositories() {
        let expectation = XCTestExpectation(description: "Fetch repositories from GitHubRepository")
        
        gitHubRepository.fetchRepositories(page: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got failure: \(error)")
                }
            }, receiveValue: { repositories in
                XCTAssertGreaterThan(repositories.count, 0, "No repositories returned")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
