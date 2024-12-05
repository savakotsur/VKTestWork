//
//  GitHubRepositoryMapper.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

final class GitHubRepositoryMapper {
    static func mapToDomain(githubItem: GitHubRepositoryItem) -> RepositoryEntity {
        return RepositoryEntity(
            id: githubItem.id,
            name: githubItem.name,
            description: githubItem.description,
            stars: githubItem.starsCount,
            url: githubItem.htmlUrl
        )
    }
}
