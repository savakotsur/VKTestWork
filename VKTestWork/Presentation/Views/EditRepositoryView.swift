//
//  EditRepositoryView.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import SwiftUI

struct EditRepositoryView: View {
    @StateObject var viewModel: EditRepositoryViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Name", text: $viewModel.repository.name)
            TextField("Description", text: Binding(
                get: { viewModel.repository.description ?? "" },
                set: { viewModel.repository.description = $0 }
            ))
            
            Button("Save") {
                viewModel.saveChanges()
                dismiss()
            }
        }
        .navigationBarTitle("Edit Repository")
    }
}
