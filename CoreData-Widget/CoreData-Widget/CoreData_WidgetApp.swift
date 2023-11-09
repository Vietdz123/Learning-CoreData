//
//  CoreData_WidgetApp.swift
//  CoreData-Widget
//
//  Created by MAC on 08/11/2023.
//

import SwiftUI

@main
struct CoreData_WidgetApp: App {
    @State private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            CategoryView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
