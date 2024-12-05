//
//  VKTestWorkApp.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import SwiftUI
import SwiftData

@main
struct VKTestWorkApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Repository.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            let modelContext = ModelContext(sharedModelContainer)
            
            RepositoriesListView(viewModel: RepositoriesListViewModel(
                repository: GitHubRepository(apiService: GitHubAPIService()),
                modelContext: modelContext))
        }
    }
    
}
