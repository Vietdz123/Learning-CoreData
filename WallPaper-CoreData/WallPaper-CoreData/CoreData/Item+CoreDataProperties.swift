//
//  Item+CoreDataProperties.swift
//  Wallpaper-WidgetExtension
//
//  Created by MAC on 13/11/2023.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var creationDate: Double
    @NSManaged public var family: String?
    @NSManaged public var name: String?
    @NSManaged public var routine_type: String?
    
    @NSManaged public var day_mon: Double
    @NSManaged public var day_sun: Double
    @NSManaged public var day_tues: Double
    @NSManaged public var day_wed: Double
    @NSManaged public var day_thur: Double
    @NSManaged public var day_fir: Double
    @NSManaged public var day_sat: Double

}

extension Item : Identifiable {

}
