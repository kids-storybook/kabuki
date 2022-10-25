//
//  Stories+CoreDataProperties.swift
//  Storybook
//
//  Created by zy on 31/10/22.
//
//

import Foundation
import CoreData


extension Stories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stories> {
        return NSFetchRequest<Stories>(entityName: "Stories")
    }

    @NSManaged public var challengeName: String?
    @NSManaged public var labels: Array<String>?
    @NSManaged public var order: Int32
    @NSManaged public var background: String?
    @NSManaged public var character: String?

}

extension Stories : Identifiable {

}
