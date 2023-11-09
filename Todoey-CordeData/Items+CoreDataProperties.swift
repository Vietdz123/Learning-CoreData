//
//  Items+CoreDataProperties.swift
//  Todoey-CordeData
//
//  Created by MAC on 08/11/2023.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var flagCheck: Bool
    @NSManaged public var nameItem: String?
    @NSManaged public var toCategory: Category?

}

extension Items : Identifiable {

}
