//
//  GitHubAPIServiceTests.swift
//  VKTestWorkTests
//
//  Created by Савелий Коцур on 05.12.2024.
//

import XCTest
import Combine
@testable import VKTestWork

final class GitHubAPIServiceTests: XCTestCase {
    var apiService: GitHubAPIService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        apiService = GitHubAPIService(session: URLSession.shared)
        cancellables = []
    }
    
    func testFetchRepositories() {
        let expectation = XCTestExpectation(description: "Fetch repositories from GitHub API")
        
        apiService.fetchRepositories(page: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got failure: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertGreaterThan(response.items.count, 0, "No items returned from API")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
