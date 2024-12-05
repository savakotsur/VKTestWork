//
//  RepositoryMapper.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import Foundation

struct RepositoryMapper {
    static func mapToDomain(repository: Repository) -> RepositoryEntity {
        return RepositoryEntity(
            id: repository.id,
            name: repository.name,
            description: repository.repoDescription,
            stars: repository.starsCount,
            url: repository.htmlURL
        )
    }

    static func mapToData(entity: RepositoryEntity) -> Repository {
        return Repository(
            id: entity.id,
            name: entity.name,
            repoDescription: entity.description,
            starsCount: entity.stars,
            htmlURL: entity.url
        )
    }
}
