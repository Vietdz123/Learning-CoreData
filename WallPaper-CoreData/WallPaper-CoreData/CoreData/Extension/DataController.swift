//
//  DataController.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container: NSPersistentContainer

    init() {
        let storeURL = WDConstant.containerURL.appendingPathComponent("WidgetModel.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)
        
        self.container = NSPersistentContainer(name: "WidgetModel")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        print("DEBUG: \(String(describing: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first))")
    }
}
