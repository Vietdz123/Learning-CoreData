//
//  DataController.swift
//  CoreData-Widget
//
//  Created by MAC on 08/11/2023.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Anime")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("DEBUG: \(urls[urls.count-1] as URL)")

    }
}
