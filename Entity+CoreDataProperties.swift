//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Quan on 7/14/17.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var avValue: String?
    @NSManaged public var captureDate: String?
    @NSManaged public var image: String?
    @NSManaged public var loviValue: String?

}
