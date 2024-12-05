//
//  RepositoryMapperTests.swift
//  VKTestWorkTests
//
//  Created by Савелий Коцур on 05.12.2024.
//

import XCTest
@testable import VKTestWork

final class RepositoryMapperTests: XCTestCase {

    func testMapToDomain() {
        let repository = Repository(id: 1, name: "Repo1", repoDescription: "Description", starsCount: 5, htmlURL: "url.com")
        let entity = RepositoryMapper.mapToDomain(repository: repository)
        
        XCTAssertEqual(entity.id, repository.id)
        XCTAssertEqual(entity.name, repository.name)
        XCTAssertEqual(entity.description, repository.repoDescription)
        XCTAssertEqual(entity.stars, repository.starsCount)
        XCTAssertEqual(entity.url, repository.htmlURL)
    }

    func testMapToData() {
        let entity = RepositoryEntity(id: 1, name: "Repo1", description: "Description", stars: 5, url: "url.com")
        let repository = RepositoryMapper.mapToData(entity: entity)
        
        XCTAssertEqual(repository.id, entity.id)
        XCTAssertEqual(repository.name, entity.name)
        XCTAssertEqual(repository.repoDescription, entity.description)
        XCTAssertEqual(repository.starsCount, entity.stars)
        XCTAssertEqual(repository.htmlURL, entity.url)
    }
}
