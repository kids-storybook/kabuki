//
//  AnimatedGame+CoreDataProperties.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/11/22.
//
//

import Foundation
import CoreData


extension AnimatedGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnimatedGame> {
        return NSFetchRequest<AnimatedGame>(entityName: "AnimatedGame")
    }

    @NSManaged public var challengeName: String?
    @NSManaged public var characterAtlas: String?
    @NSManaged public var characterXPosition: Double
    @NSManaged public var characterYPosition: Double

}

extension AnimatedGame : Identifiable {

}
