//
//  EditRepositoryViewModel.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import Foundation
import SwiftData

final class EditRepositoryViewModel: ObservableObject {
    private let modelContext: ModelContext
    var repository: RepositoryEntity
    private let onSave: (RepositoryEntity) -> Void
    
    init(modelContext: ModelContext, repository: RepositoryEntity, onSave: @escaping (RepositoryEntity) -> Void) {
        self.modelContext = modelContext
        self.repository = repository
        self.onSave = onSave
    }
    
    func saveChanges() {
        do {
            try modelContext.save()
            onSave(repository)
        } catch {
            print("Error saving repository: \(error)")
        }
    }
}
