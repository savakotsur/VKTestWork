//
//  ContentView.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import SwiftUI

struct RepositoriesListView: View {
    @StateObject var viewModel: RepositoriesListViewModel
    @State var isEditing: Bool = false
    @State private var selectedRepository: RepositoryEntity?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.repositories) { repository in
                        RepositoryCardView(repository: repository)
                            .task {
                                if viewModel.hasReachedEnd(of: repository) {
                                    viewModel.loadMoreRepositories()
                                }
                            }
                            .contextMenu {
                                Button(action: {
                                    viewModel.deleteRepository(repository)
                                }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                                Button(action: {
                                    selectedRepository = repository
                                    isEditing.toggle()
                                }) {
                                    Text("Edit")
                                    Image(systemName: "pencil")
                                }
                            }
                            .sheet(item: $selectedRepository) { selectedRepo in
                                EditRepositoryView(viewModel: EditRepositoryViewModel(
                                    modelContext: viewModel.modelContext,
                                    repository: selectedRepo,
                                    onSave: { updatedRepository in
                                        if let index = viewModel.repositories.firstIndex(where: { $0.id == updatedRepository.id }) {
                                            viewModel.repositories[index] = updatedRepository
                                            Task {
                                                await viewModel.updateRepositoryInLocalStorage(repository: updatedRepository)
                                            }
                                        }
                                    }
                                ))
                            }
                    }
                    
                    
                    if viewModel.isLoading {
                        ProgressCircleView()
                    }
                }
                .navigationBarTitle("Repositories")
            }
        }
    }
}
