//
//  Stories+CoreDataProperties.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 31/10/22.
//
//

import Foundation
import CoreData


extension Stories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stories> {
        return NSFetchRequest<Stories>(entityName: "Stories")
    }

    @NSManaged public var background: String?
    @NSManaged public var title: String?
    @NSManaged public var challengeName: String?
    @NSManaged public var character: String?
    @NSManaged public var labels: Array<String>?
    @NSManaged public var order: Int32
    @NSManaged public var characterXPosition: Double
    @NSManaged public var characterYPosition: Double

}

extension Stories : Identifiable {

}
