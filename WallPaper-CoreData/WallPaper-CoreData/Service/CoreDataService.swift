//
//  CoreDataService.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI
import CoreData

class CoreDataService {
    
    let context = DataController().container.viewContext
    
    static let shared = CoreDataService()
    
    func getAllCategory() -> [Category] {
        let request = Category.fetchRequest()
        
        do {
            let categories = try context.fetch(request)
            return categories
        } catch {
            print("Error fetching data from context \(error)")
            return []
        }
    }
    
    func getSuggestedName() -> [String] {
        let categories = getAllCategory()
        
        let names =  categories.map { $0.unwrappedName }
        print("DEBUG: \(names)")
        return names
    }
    
    func getImages(category: Category, family: FamilyFolderType) -> [UIImage] {
        
        let items = category.itemArray
        
        let filterItems = items.filter { item in
            return item.unwrappedFamily.contains(family.rawValue)
        }
        
        var images: [UIImage] = []
        filterItems.forEach { item in
            guard let image = FileService.shared.readImage(item: item) else { return }
            images.append(image)
        }
        
        print("DEBUG: getImages \(images.count)")
        return images
    }
    
    
    func getCategory(name: String) -> Category {
        
        let query = NSPredicate(format: "%K CONTAINS %@", #keyPath(Category.name), name)
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = query
        
        guard let category = try? context.fetch(request).first else { return Category(context: context) }
        
        return category
        
    }
    
    func getFolderType(with nameFolder: String) -> WDFolderType {
        
        return WDFolderType.getType(name: nameFolder)
    }
    
    func getRoutineType(with nameRoutine: String) -> RoutinMonitorType {
        return RoutinMonitorType.getType(name: nameRoutine)
    }
    
    func getButtonCheckListModel(category: Category) -> ButtonCheckListModel {
        
        let items = category.itemArray
        
        let checkItems = items.filter { item in
            return item.unwrappedFamily.contains(FamilyFolderType.check.rawValue)
        }
        
        let uncheckItems = items.filter { item in
            return item.unwrappedFamily.contains(FamilyFolderType.uncheck.rawValue)
        }
        
        var checkImages: [UIImage] = []
        var uncheckImages: [UIImage] = []
        
        
        checkItems.forEach { item in
            guard let image = FileService.shared.readImage(item: item) else { return }
            checkImages.append(image)
        }
        
        uncheckItems.forEach { item in
            guard let image = FileService.shared.readImage(item: item) else { return }
            uncheckImages.append(image)
        }
        
        return ButtonCheckListModel(checkImage: checkImages, uncheckImage: uncheckImages)
    }

}


extension CoreDataService {
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    func loadData(request: NSFetchRequest<Item> = Item.fetchRequest(), precticate: NSPredicate? = nil) {
//        guard let nameCategory = category.name else {
//            return
//        }
//        
//        let query = NSPredicate(format: "%K CONTAINS %@", #keyPath(Item.toCategory.name), nameCategory)
//        
//        if let precticate = precticate {
//            let queryCompound = NSCompoundPredicate(andPredicateWithSubpredicates: [precticate, query])
//            request.predicate = queryCompound
//        } else {
//            request.predicate = query
//        }
//        let sort = NSSortDescriptor(key: "name", ascending: true)
//        request.sortDescriptors = [sort]
//        do {
//            self.items = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
    

    
    
}
