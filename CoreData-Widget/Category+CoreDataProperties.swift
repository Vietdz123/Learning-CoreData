//
//  Category+CoreDataProperties.swift
//  CoreData-Widget
//
//  Created by MAC on 08/11/2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: Item?

}

extension Category : Identifiable {

}
