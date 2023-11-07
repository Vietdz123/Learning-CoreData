//
//  Category+CoreDataProperties.swift
//  Todoey-CordeData
//
//  Created by Long Bảo on 14/03/2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var nameCategory: String?
    @NSManaged public var toMultiItems: NSSet?

}

// MARK: Generated accessors for toMultiItems
extension Category {

    @objc(addToMultiItemsObject:)
    @NSManaged public func addToToMultiItems(_ value: Items)

    @objc(removeToMultiItemsObject:)
    @NSManaged public func removeFromToMultiItems(_ value: Items)

    @objc(addToMultiItems:)
    @NSManaged public func addToToMultiItems(_ values: NSSet)

    @objc(removeToMultiItems:)
    @NSManaged public func removeFromToMultiItems(_ values: NSSet)

}

extension Category : Identifiable {

}
