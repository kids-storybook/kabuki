//
//  Challenges+CoreDataProperties.swift
//  Storybook
//
//  Created by zy on 27/10/22.
//
//

import Foundation
import CoreData


extension Challenges {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenges> {
        return NSFetchRequest<Challenges>(entityName: "Challenges")
    }

    @NSManaged public var background: String?
    @NSManaged public var challengeName: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var xCoordinate: Double
    @NSManaged public var yCoordinate: Double
    @NSManaged public var zPosition: Double

}

extension Challenges : Identifiable {

}
