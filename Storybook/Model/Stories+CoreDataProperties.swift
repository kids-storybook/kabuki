//
//  Stories+CoreDataProperties.swift
//  Storybook
//
//  Created by zy on 24/10/22.
//
//

import Foundation
import CoreData


extension Stories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stories> {
        return NSFetchRequest<Stories>(entityName: "Stories")
    }

    @NSManaged public var challengeName: String?
    @NSManaged public var labels: NSObject?
    @NSManaged public var order: Int32

}

extension Stories : Identifiable {

}
