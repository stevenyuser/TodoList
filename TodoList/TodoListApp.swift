//
//  TodoListApp.swift
//  TodoList
//
//  Created by Steven Yu on 10/3/21.
//

import SwiftUI


// CODE IS FROM SWIFTFUL THINKING ON YOUTUBE

/*
 MVVM Architecture
 
 Model - data point
 View - UI
 ViewModel - manages Models for View
 
 */

@main
struct TodoListApp: App {
    
    // StateObject to make sure all views in the heirarchy can access the same ViewModel class
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle()) // prevents against iPad error
            .environmentObject(listViewModel) // makes sure all views can see the array
        }
    }
}
