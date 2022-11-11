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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        container = appDelegate.persistentContainer
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
    
    func initializeDB (context: NSManagedObjectContext) {
        context.automaticallyMergesChangesFromParent = true
        //        context.perform {
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = Themes.fetchRequest()
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            // TODO: handle the error
            print(error)
        }
        
        for data in initThemeData {
            let theme = Themes(context: context)
            theme.background = data.background
            theme.mapBackground = data.mapBackground
            theme.name = data.name
            theme.isActive = data.isActive ?? false
            
            var challenges: [Challenges] = []
            
            for c in data.challenges{
                let challenge = Challenges(context: context)
                challenge.isActive = c?.isActive ?? false
                challenge.background = c?.background
                challenge.zPosition = c?.zPosition ?? 0.0
                challenge.challengeName = c?.challengeName
                challenge.xCoordinate = c?.xCoordinate ?? 0.0
                challenge.yCoordinate = c?.yCoordinate ?? 0.0
                challenge.gameBackground = c?.gameBackground
                challenge.level = c?.level?.rawValue
                challenge.nextChallenge = c?.nextChallenge
                challenges.append(challenge)
            }
            theme.addToChallenges(NSOrderedSet(array: challenges))
            self.saveContext(saveContext: context)
        }
        
        fetchRequest = Stories.fetchRequest()
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            // TODO: handle the error
            print(error)
        }
        
        for data in initAssessmentData {
            let story = Stories(context: context)
            story.challengeName = data.challengeName
            story.title = data.title
            story.order = data.order
            story.labels = data.labels as? [String]
            story.labelColor = data.labelColor?.rawValue
            story.background = data.background
            story.character = data.character
            story.characterAtlas = data.characterAtlas
            story.characterXPosition = data.characterXPosition ?? 0.0
            story.characterYPosition = data.characterYPosition ?? 0.0
            self.saveContext(saveContext: context)
        }
        
        fetchRequest = Shapes.fetchRequest()
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            // TODO: handle the error
            print(error)
        }
        
        for data in initShapeData {
            let shape = Shapes(context: context)
            shape.challengeName = data.challengeName
            shape.order = data.order
            shape.background = data.background
            self.saveContext(saveContext: context)
        }
        
        fetchRequest = AnimatedShapes.fetchRequest()
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            // TODO: handle the error
            print(error)
        }
        
        for data in initAnimationData {
            let animatedShape = AnimatedShapes(context: context)
            animatedShape.challengeName = data.challengeName
            animatedShape.shapeImage = data.shapeImage
            animatedShape.xCoordinateShape = data.xCoordinateShape ?? 0.0
            animatedShape.yCoordinateShape = data.yCoordinateShape ?? 0.0
            animatedShape.shapeName = data.shapeName
            animatedShape.xCoordinateFont = data.xCoordinateFont ?? 0.0
            animatedShape.yCoordinateFont = data.yCoordinateFont ?? 0.0
            self.saveContext(saveContext: context)
        }
        
        fetchRequest = AnimatedGame.fetchRequest()
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            // TODO: handle the error
            print(error)
        }
        
        for data in initAnimatedGameCharacterData {
            let animatedGame = AnimatedGame(context: context)
            animatedGame.challengeName = data.challengeName
            animatedGame.characterAtlas = data.characterAtlas
            animatedGame.characterXPosition = data.characterXPosition ?? 0.0
            animatedGame.characterYPosition = data.characterYPosition ?? 0.0
            self.saveContext(saveContext: context)
        }
        
        do {
            let themes = try context.fetch(Themes.fetchRequest())
            for data in themes {
                print(data.name ?? "")
            }
            
            let stories = try context.fetch(Stories.fetchRequest())
            for data in stories {
                print(data.labels ?? [])
            }
            
            let challenges = try context.fetch(Challenges.fetchRequest())
            for data in challenges {
                print(data.challengeName ?? "")
            }
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        //        }
    }
}
