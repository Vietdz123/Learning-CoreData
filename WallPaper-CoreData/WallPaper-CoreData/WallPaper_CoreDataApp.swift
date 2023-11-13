//
//  WallPaper_CoreDataApp.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI

@main
struct WallPaper_CoreDataApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
