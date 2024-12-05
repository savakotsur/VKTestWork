//
//  FetchRepositoriesUseCaseTests.swift
//  VKTestWorkTests
//
//  Created by Савелий Коцур on 05.12.2024.
//

import XCTest
import Combine
@testable import VKTestWork

final class FetchRepositoriesUseCaseTests: XCTestCase {
    var useCase: FetchRepositoriesUseCase!
    var mockRepository: MockRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockRepository()
        useCase = FetchRepositoriesUseCase(repository: mockRepository)
        cancellables = []
    }

    func testExecute_ShouldReturnRepositories() {
        let expectation = XCTestExpectation(description: "Fetch repositories using use case")

        useCase.execute(page: 1)
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

    func testExecute_ShouldReturnError() {
        let expectation = XCTestExpectation(description: "Fetch repositories should return error")

        mockRepository.shouldReturnError = true

        useCase.execute(page: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error, "Expected error, but got success")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }
}
