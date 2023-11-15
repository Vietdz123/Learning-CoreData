//
//  Category+CoreDataProperties.swift
//  WallPaper-CoreData
//
//  Created by MAC on 15/11/2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var creationDate: Double
    @NSManaged public var currentIndexDigitalFriend: Double
    @NSManaged public var folderType: String?
    @NSManaged public var name: String?
    @NSManaged public var routineType: String?
    @NSManaged public var hasSound: Bool
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Category {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
