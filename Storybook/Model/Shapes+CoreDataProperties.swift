//
//  Shapes+CoreDataProperties.swift
//  Storybook
//
//  Created by zy on 27/10/22.
//
//

import Foundation
import CoreData


extension Shapes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shapes> {
        return NSFetchRequest<Shapes>(entityName: "Shapes")
    }

    @NSManaged public var background: String?
    @NSManaged public var challengeName: String?
    @NSManaged public var order: Int32

}

extension Shapes : Identifiable {

}
