//
//  Stories+CoreDataProperties.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/11/22.
//
//

import Foundation
import CoreData

extension Stories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stories> {
        return NSFetchRequest<Stories>(entityName: "Stories")
    }

    @NSManaged public var background: String?
    @NSManaged public var challengeName: String?
    @NSManaged public var character: String?
    @NSManaged public var characterAtlas: String?
    @NSManaged public var characterXPosition: Double
    @NSManaged public var characterYPosition: Double
    @NSManaged public var labelColor: String?
    @NSManaged public var labels: [String]?
    @NSManaged public var order: Int32
    @NSManaged public var title: String?

}

extension Stories: Identifiable {

}
