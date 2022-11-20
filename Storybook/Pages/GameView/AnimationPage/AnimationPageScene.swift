//
//  AnimationPageScene.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit
import UIKit

class AnimationPageScene: GameScene {

    var animateShape: [AnimatedShapes]?
    var activeShapes: [AnimatedShape] = []
    var totalStories: Int?
    var backgroundScene: Background?
    var activeLabels: [SKLabelNode]?

    private func setupPlayer() {

        makeCharacterTutorial(
            imageName: self.story?.characterAtlas,
            sound: Audio.EffectFiles.animal[self.challengeName ?? ""]
        )

        // Add background
        backgroundScene = Background(imageName: self.story?.background ?? "")
        if let background = backgroundScene {
            let spriteComponent = background.component(ofType: SpriteComponent.self)
            spriteComponent?.node.size = self.frame.size
            entityManager.add(background)
        }

        let rawLabels = story?.labels as? [String]

        if let labels = rawLabels {
            for (idx, label) in labels.enumerated() {
                let textScene = SKLabelNode(fontNamed: "Poppins-Black")
                textScene.text = label
                textScene.fontSize = 50
                textScene.fontColor = SKColor.white
                textScene.position = CGPoint(x: 0, y: Int(Double(frame.height)/3.5)-idx*60)
                textScene.zPosition = 100
                textScene.addStroke(color: UIColor(named: story?.labelColor ?? "") ?? textBorder, width: 7.0)
                addChild(textScene)
                activeLabels?.append(textScene)
            }
        }
    }

    func setupShapes() {

        // Create shapes
        for shape in (animateShape ?? []) {
            let activeShape = AnimatedShape(
                imageName: shape.shapeImage ?? "",
                sound: Audio.EffectFiles.shape[shape.shapeName ?? ""]
            )
            if let spriteComponent = activeShape.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: shape.xCoordinateShape, y: shape.yCoordinateShape)
                spriteComponent.node.setScale(0.85)
                spriteComponent.node.name = shape.shapeName
            }
            activeShapes.append(activeShape)
            entityManager.add(activeShape)
        }
    }

    override func didMove(to view: SKView) {

        // Fetch Stories Model
        entityManager = EntityManager(scene: self)
        do {
            let fetchRequest = Stories.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == 0")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "") + "_animate")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            fetchRequest.fetchLimit = 1
            story = try context.fetch(fetchRequest)[0]

            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "") + "_animate")

            totalStories = try context.count(for: fetchRequest)
        } catch let error as NSError {
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }

        // Fetch AnimatedShapes Model
        do {
            let fetchRequest = AnimatedShapes.fetchRequest()
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? ""))
            fetchRequest.predicate = challengeNamePredicate

            animateShape = try context.fetch(fetchRequest)
        } catch let error as NSError {
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }

        self.setupPlayer()
        self.setupShapes()
    }

    override func getNextScene() -> SKScene? {
        let scene = SKScene(fileNamed: "AnimationPageSceneTutorial") as? AnimationPageSceneTutorial
        scene?.challengeName = self.challengeName
        scene?.theme = self.theme
        return scene
    }

    override func getPreviousScene() -> SKScene? {
        let scene = SKScene(fileNamed: "StoryPageScene") as? StoryPageScene
        scene?.idxScene = self.idxScene
        scene?.challengeName = self.challengeName
        scene?.theme = self.theme
        return scene
    }

    override func exitScene() -> SKScene? {
        AudioPlayerImpl.sharedInstance.stop()
        let scene = SKScene(fileNamed: "MapViewPageScene") as? MapViewPageScene
        scene?.theme = self.theme
        return scene
    }

    override func willMove(from view: SKView) {
        if let background = backgroundScene {
            entityManager.remove(background)
        }

        for shape in self.activeShapes {
            entityManager.remove(shape)
        }

        for label in (self.activeLabels ?? []) as [SKLabelNode] {
            label.removeFromParent()
            label.removeAllChildren()
        }
    }
}
