//
//  ProgressCircleView.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import SwiftUI

struct ProgressCircleView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding(.vertical, 20)
            Spacer()
        }
    }
}
