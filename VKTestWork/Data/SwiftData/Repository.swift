//
//  Repository.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//
import Foundation
import SwiftData

@Model
final class Repository: Identifiable {
    var id: Int
    var name: String
    var repoDescription: String?
    var starsCount: Int
    var htmlURL: String

    init(id: Int, name: String, repoDescription: String?, starsCount: Int, htmlURL: String) {
        self.id = id
        self.name = name
        self.repoDescription = repoDescription
        self.starsCount = starsCount
        self.htmlURL = htmlURL
    }
}
