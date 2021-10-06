//
//  ItemModel.swift
//  TodoList
//
//  Created by Steven Yu on 10/3/21.
//

import Foundation

// Immutable Struct
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    // initializes id to be a UUID, unless ID is specified (this is to pass in an existing object like in updateCompletion())
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    // returns an ItemModel with the same id and title, but with a true isCompleted
    // you first declare an item and then call this func on that item, will preserve the unique id and title
    func updateCompetion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
