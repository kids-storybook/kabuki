//
//  Utils.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import Foundation
import CoreData
import UIKit

class Helper {
    var container: NSPersistentContainer!

    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        container = appDelegate?.persistentContainer
    }

    func getBackgroundContext () -> NSManagedObjectContext {
        return container.viewContext
    }

    func saveContext(saveContext: NSManagedObjectContext?) {
        guard let context = saveContext else { return }
        do {
            try context.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }

    func seedingThemes(context: NSManagedObjectContext) {
        for data in themes {
            let theme = Themes(context: context)
            theme.background = data.background
            theme.mapBackground = data.mapBackground
            theme.name = data.name
            theme.isActive = data.isActive ?? false

            let challenges: [Challenges] = seedingChallenges(context: context, data: data)

            theme.addToChallenges(NSOrderedSet(array: challenges))
            self.saveContext(saveContext: context)
        }
    }

    func seedingChallenges(context: NSManagedObjectContext, data: ThemeModel) -> [Challenges] {
        var challenges: [Challenges] = []
        for challengeModel in data.challenges ?? [] {
            let challenge = Challenges(context: context)
            challenge.isActive = challengeModel?.isActive ?? false
            challenge.background = challengeModel?.background
            challenge.zPosition = challengeModel?.zPosition ?? 0.0
            challenge.challengeName = challengeModel?.challengeName
            challenge.xCoordinate = challengeModel?.xCoordinate ?? 0.0
            challenge.yCoordinate = challengeModel?.yCoordinate ?? 0.0
            challenge.gameBackground = challengeModel?.gameBackground
            challenge.level = challengeModel?.level?.rawValue
            challenge.nextChallenge = challengeModel?.nextChallenge
            challenges.append(challenge)
        }
        return challenges
    }

    func seedingStories(context: NSManagedObjectContext) {
        for data in stories {
            let story = Stories(context: context)
            story.challengeName = data.challengeName
            story.title = data.title
            story.order = data.order ?? 0
            story.labels = data.labels as? [String]
            story.labelColor = data.labelColor?.rawValue
            story.background = data.background
            story.character = data.character
            story.characterAtlas = data.characterAtlas
            story.characterXPosition = data.characterXPosition ?? 0.0
            story.characterYPosition = data.characterYPosition ?? 0.0
            self.saveContext(saveContext: context)
        }
    }

    func seedingShapes(context: NSManagedObjectContext) {
        for data in shapes {
            let shape = Shapes(context: context)
            shape.challengeName = data.challengeName
            shape.order = data.order ?? 0
            shape.background = data.background
            self.saveContext(saveContext: context)
        }
    }

    func seedingAnimatedShapes(context: NSManagedObjectContext) {
        for data in shapeAnimations {
            let shapeAnimation = AnimatedShapes(context: context)
            shapeAnimation.challengeName = data.challengeName
            shapeAnimation.shapeImage = data.shapeImage
            shapeAnimation.xCoordinateShape = data.xCoordinateShape ?? 0.0
            shapeAnimation.yCoordinateShape = data.yCoordinateShape ?? 0.0
            shapeAnimation.shapeName = data.shapeName
            shapeAnimation.xCoordinateFont = data.xCoordinateFont ?? 0.0
            shapeAnimation.yCoordinateFont = data.yCoordinateFont ?? 0.0
            self.saveContext(saveContext: context)
        }
    }

    func seedingCharacters(context: NSManagedObjectContext) {
        for data in characters {
            let character = Characters(context: context)
            character.challengeName = data.challengeName
            character.characterAtlas = data.characterAtlas
            character.characterXPosition = data.characterXPosition ?? 0.0
            character.characterYPosition = data.characterYPosition ?? 0.0
            self.saveContext(saveContext: context)
        }
    }

    func resetAllRecords(entity: String, context: NSManagedObjectContext) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }

    func initializeDB (context: NSManagedObjectContext) {
        context.automaticallyMergesChangesFromParent = true

        resetAllRecords(entity: "Themes", context: context)
        resetAllRecords(entity: "Stories", context: context)
        resetAllRecords(entity: "Shapes", context: context)
        resetAllRecords(entity: "AnimatedShapes", context: context)
        resetAllRecords(entity: "Characters", context: context)

        self.seedingThemes(context: context)
        self.seedingStories(context: context)
        self.seedingShapes(context: context)
        self.seedingAnimatedShapes(context: context)
        self.seedingCharacters(context: context)

    }
}
