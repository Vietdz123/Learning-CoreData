//
//  ExtensionCoreData.swift
//  CoreData-Widget
//
//  Created by MAC on 13/11/2023.
//

import Foundation
import CoreData

extension Category {
    
    public var unwrappedName: String {
        return name ?? "Unknown name"
    }
    
    public var itemArray: [Item] {
        let itemSet = items as? Set<Item> ?? []
        
        
        return itemSet.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
    
}


extension Item {
    
    public var unwrappedName: String {
        return name ?? "Unknown name"
    }
    
}
