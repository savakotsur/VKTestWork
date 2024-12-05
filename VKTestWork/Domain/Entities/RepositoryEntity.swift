//
//  Repository.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

struct RepositoryEntity: Identifiable {
    let id: Int
    var name: String
    var description: String?
    let stars: Int
    let url: String
}
