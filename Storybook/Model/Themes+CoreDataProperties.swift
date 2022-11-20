//
//  Themes+CoreDataProperties.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/11/22.
//
//

import Foundation
import CoreData

extension Themes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Themes> {
        return NSFetchRequest<Themes>(entityName: "Themes")
    }

    @NSManaged public var background: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var mapBackground: String?
    @NSManaged public var name: String?
    @NSManaged public var challenges: NSOrderedSet?

}

// MARK: Generated accessors for challenges
extension Themes {

    @objc(insertObject:inChallengesAtIndex:)
    @NSManaged public func insertIntoChallenges(_ value: Challenges, at idx: Int)

    @objc(removeObjectFromChallengesAtIndex:)
    @NSManaged public func removeFromChallenges(at idx: Int)

    @objc(insertChallenges:atIndexes:)
    @NSManaged public func insertIntoChallenges(_ values: [Challenges], at indexes: NSIndexSet)

    @objc(removeChallengesAtIndexes:)
    @NSManaged public func removeFromChallenges(at indexes: NSIndexSet)

    @objc(replaceObjectInChallengesAtIndex:withObject:)
    @NSManaged public func replaceChallenges(at idx: Int, with value: Challenges)

    @objc(replaceChallengesAtIndexes:withChallenges:)
    @NSManaged public func replaceChallenges(at indexes: NSIndexSet, with values: [Challenges])

    @objc(addChallengesObject:)
    @NSManaged public func addToChallenges(_ value: Challenges)

    @objc(removeChallengesObject:)
    @NSManaged public func removeFromChallenges(_ value: Challenges)

    @objc(addChallenges:)
    @NSManaged public func addToChallenges(_ values: NSOrderedSet)

    @objc(removeChallenges:)
    @NSManaged public func removeFromChallenges(_ values: NSOrderedSet)

}

extension Themes: Identifiable {

}
