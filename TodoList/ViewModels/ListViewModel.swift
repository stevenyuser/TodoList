//
//  ListViewModel.swift
//  TodoList
//
//  Created by Steven Yu on 10/3/21.
//

import Foundation

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 */

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        // saves items each time items is changed
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    // uses a guard  to try to get data from UserDefaults, if UserDefaults returns null, it will exit, just making a new empty array
    // uses a guard to try and decode the UserDefaults data to an ItemModel type, otherwise returns null and exits, making a new empty array
    // if passes statements and decodes JSON into ItemModel, saves the saved UserDefaults data into the items array
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    // removes item at index
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    // moves item from a specified index to a new position
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    // creates item and appends it
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    // get item where the item's unique id is equal to the paramater's item id
    // basically gets item and makes the completion from false to true and replaces the item in the index with the new completed item
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompetion()
        }
    }
    
    // tries to encode the items array into a json object to save to UserDefaults
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
