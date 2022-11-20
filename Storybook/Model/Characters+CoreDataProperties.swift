//
//  Characters+CoreDataProperties.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/11/22.
//
//

import Foundation
import CoreData

extension Characters {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Characters> {
        return NSFetchRequest<Characters>(entityName: "Characters")
    }

    @NSManaged public var challengeName: String?
    @NSManaged public var characterAtlas: String?
    @NSManaged public var characterXPosition: Double
    @NSManaged public var characterYPosition: Double

}

extension Characters: Identifiable {

}
