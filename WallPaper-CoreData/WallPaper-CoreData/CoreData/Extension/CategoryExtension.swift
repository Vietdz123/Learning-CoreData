//
//  CategoryExtension.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI


extension Category {
    
    @NSManaged var currentCheckImageRoutine: [Double]
    @NSManaged var isCheckedRoutine: [Bool]
    
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

class ArrayDoubleTransformer: ValueTransformer {
    /// Dùng để convert `Type` sang `Data`.
    override func transformedValue(_ value: Any?) -> Any? {
        guard let dataArray = value as? Array<Double> else { return nil }
        do {
          let data = try NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
            return data
        } catch {
          return nil
        }
    }

    /// Dùng để convert `Data` sang `Type`.
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: data) as? [Double]
            return image
        } catch {
            return nil
        }
    }
}

class ArrayBoolTransformer: ValueTransformer {
    /// Dùng để convert `Type` sang `Data`.
    override func transformedValue(_ value: Any?) -> Any? {
        guard let dataBool = value as? Array<Bool> else { return nil }
        do {
          let data = try NSKeyedArchiver.archivedData(withRootObject: dataBool, requiringSecureCoding: true)
            return data
        } catch {
          return nil
        }
    }

    /// Dùng để convert `Data` sang `Type`.
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: data) as? [Bool]
            return image
        } catch {
            return nil
        }
    }
}
