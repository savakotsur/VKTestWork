//
//  Item.swift
//  VKTestWork
//
//  Created by Савелий Коцур on 05.12.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
