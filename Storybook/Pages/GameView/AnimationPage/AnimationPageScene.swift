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
    
    var story: Stories?
    var animateShape: [AnimatedShapes]?
    var activeShapes: [AnimatedShape] = []
    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    
    private func setupPlayer(){
        
        makeCharacterTutorial(imageName: self.story?.character)
        
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        
        addChild(backgroundScene)
        
        let rawLabels = story?.labels as? [String]
        
        if let labels = rawLabels {
            for (idx, label) in labels.enumerated() {
                let textScene = SKLabelNode(fontNamed: "Poppins-Black")
                textScene.text = label
                textScene.fontSize = 50
                textScene.fontColor = SKColor.white
                textScene.position = CGPoint(x: 0, y: Int(frame.height)/3-idx*60)
                textScene.zPosition = 100
                textScene.addStroke(color: textBorder, width: 7.0)
                addChild(textScene)
            }
        }
    }
    
    func setupShapes() {
        
        //Create shapes
        for (_, shape) in (animateShape ?? []).enumerated() {
            let activeShape = AnimatedShape(imageName: shape.shapeImage ?? "")
            if let spriteComponent = activeShape.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: shape.xCoordinateShape, y: shape.yCoordinateShape)
                spriteComponent.node.setScale(0.55)
                
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
            print(error)
            print("error while fetching data in core data!")
        }
        
        // Fetch AnimatedShapes Model
        do {
            let fetchRequest = AnimatedShapes.fetchRequest()
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? ""))
            fetchRequest.predicate = challengeNamePredicate
            
            animateShape = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        self.setupPlayer()
        self.setupShapes()
    }
    
    override func getNextScene() -> SKScene? {
        let scene = SKScene(fileNamed: "AnimationPageSceneTutorial") as! AnimationPageSceneTutorial
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        return scene
    }
    
    override func getPreviousScene() -> SKScene? {
        let scene = SKScene(fileNamed: "StoryPageScene") as! StoryPageScene
        scene.idxScene = self.idxScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        return scene
    }
    
    override func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
}
