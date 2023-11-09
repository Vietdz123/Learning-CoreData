//
//  Item+CoreDataProperties.swift
//  CoreData-Widget
//
//  Created by MAC on 08/11/2023.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var toCategory: Category?

}

extension Item : Identifiable {

}
