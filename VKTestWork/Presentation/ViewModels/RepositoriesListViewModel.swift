//
//  RepositoriesListViewModel.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import Foundation
import Combine
import SwiftData

@MainActor
class RepositoriesListViewModel: ObservableObject {
    @Published var repositories: [RepositoryEntity] = []
    @Published var isLoading: Bool = false
    private var currentPage: Int = 1
    private var isLocalDataLoaded: Bool = false
    
    private let repository: RepositoryProtocol
    let modelContext: ModelContext
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: RepositoryProtocol, modelContext: ModelContext) {
        self.repository = repository
        self.modelContext = modelContext
        Task {
            await loadRepositoriesFromLocalStorage()
        }
    }
    
    private func fetchRepositories(page: Int) {
        isLoading = true
        repository.fetchRepositories(page: page)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching repositories: \(error)")
                }
            } receiveValue: { [weak self] fetchedRepositories in
                guard let self = self else { return }
                self.repositories.append(contentsOf: fetchedRepositories)
                Task {
                    await self.saveRepositoriesToLocalStorage()
                }
            }
            .store(in: &cancellables)
    }
    
    func hasReachedEnd(of repository: RepositoryEntity) -> Bool {
        return repositories.last?.id == repository.id
    }
    
    private func loadRepositoriesFromLocalStorage() async {
        do {
            let sortDescriptor = SortDescriptor(\Repository.starsCount, order: .reverse)
            let fetchDescriptor = FetchDescriptor<Repository>(sortBy: [sortDescriptor])
            let localRepositories = try modelContext.fetch(fetchDescriptor)
            
            repositories = localRepositories.map { RepositoryMapper.mapToDomain(repository: $0) }
            isLocalDataLoaded = true
            
            print("Loaded \(repositories.count) repositories from local storage.")
        } catch {
            print("Failed to load from local storage: \(error)")
        }
        
        if repositories.isEmpty && isLocalDataLoaded {
            fetchRepositories(page: currentPage)
        }
    }
    
    func saveRepositoriesToLocalStorage() async {
        do {
            let fetchDescriptor = FetchDescriptor<Repository>()
            let existingRepositories = try modelContext.fetch(fetchDescriptor)
            let existingIDs = Set(existingRepositories.map { $0.id })

            for repository in self.repositories {
                if !existingIDs.contains(repository.id) {
                    let localRepository = RepositoryMapper.mapToData(entity: repository)
                    modelContext.insert(localRepository)
                }
            }
            
            try modelContext.save()
            print("Context saved successfully")
        } catch {
            print("Failed to save to local storage: \(error)")
        }
    }

    
    
    func loadMoreRepositories() {
        guard !isLoading else { return }
        currentPage = (repositories.count + repositories.count % 100) / 100 + 1
        fetchRepositories(page: currentPage)
    }
    
    func deleteRepository(_ repository: RepositoryEntity) {
        do {
            let fetchDescriptor = FetchDescriptor<Repository>()
            let repositories = try modelContext.fetch(fetchDescriptor)
            
            if let existingRepository = repositories.first(where: { $0.id == repository.id }) {
                modelContext.delete(existingRepository)
                
                if let index = self.repositories.firstIndex(where: { $0.id == repository.id }) {
                    self.repositories.remove(at: index)
                }
                
                try modelContext.save()
                print("Repository deleted successfully")
            } else {
                print("Repository not found for id: \(repository.id)")
            }
        } catch {
            print("Error deleting repository: \(error)")
        }
    }
    
    func updateRepositoryInLocalStorage(repository: RepositoryEntity) async {
        do {
            let fetchDescriptor = FetchDescriptor<Repository>()
            let localRepositories = try modelContext.fetch(fetchDescriptor)
            
            if let existingRepository = localRepositories.first(where: { $0.id == repository.id }) {
                existingRepository.name = repository.name
                existingRepository.repoDescription = repository.description
                
                try modelContext.save()
                print("Repository updated successfully")
            } else {
                print("Repository not found for id: \(repository.id)")
            }
        } catch {
            print("Failed to update repository in local storage: \(error)")
        }
    }
    
}
