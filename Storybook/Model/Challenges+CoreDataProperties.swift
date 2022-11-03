//
//  Challenges+CoreDataProperties.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 31/10/22.
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
    @NSManaged public var gameBackground: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var xCoordinate: Double
    @NSManaged public var yCoordinate: Double
    @NSManaged public var zPosition: Double
    @NSManaged public var level: String?
    @NSManaged public var nextChallenge: String?

}

extension Challenges : Identifiable {

}
