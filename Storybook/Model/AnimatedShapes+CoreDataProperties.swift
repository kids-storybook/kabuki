//
//  AnimatedShapes+CoreDataProperties.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/11/22.
//
//

import Foundation
import CoreData

extension AnimatedShapes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnimatedShapes> {
        return NSFetchRequest<AnimatedShapes>(entityName: "AnimatedShapes")
    }

    @NSManaged public var challengeName: String?
    @NSManaged public var shapeImage: String?
    @NSManaged public var shapeName: String?
    @NSManaged public var xCoordinateFont: Double
    @NSManaged public var xCoordinateShape: Double
    @NSManaged public var yCoordinateFont: Double
    @NSManaged public var yCoordinateShape: Double

}

extension AnimatedShapes: Identifiable {

}
