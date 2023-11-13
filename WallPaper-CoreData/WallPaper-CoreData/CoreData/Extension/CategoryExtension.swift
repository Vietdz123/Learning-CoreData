//
//  CategoryExtension.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import Foundation


extension Category {
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
    
    public var unwrappedFolder: String {
        folderType ?? "Unknown name"
    }
    
    public var unwrappedRoutineType: String {
        routineType ?? "Unknown name"
    }
    
    public var itemArray: [Item] {
        
        let itemSet = items as? Set<Item> ?? []
        
        return itemSet.sorted {
            $0.creationDate < $1.creationDate
        }
    }
    
    func getItemFamily(filter: FamilyFolderType) -> [Item] {
        
        let itemSet = items as? Set<Item> ?? []
        
        let familyItem = itemSet.filter { item in
            return item.unwrappedFamily.contains(filter.rawValue)
        }
        
        return familyItem.sorted {
            $0.creationDate < $1.creationDate
        }
    }
    

}
