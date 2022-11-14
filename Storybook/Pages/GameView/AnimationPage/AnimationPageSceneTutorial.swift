//
//  AnimationPageSceneTutorial.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit
import UIKit

class AnimationPageSceneTutorial: GameScene {
    var challenge: Challenges?
    var animateShape: [AnimatedShapes]?
    var activeShapes: [AnimatedShape] = []
    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    var bgOpacity = SKSpriteNode(imageNamed: "opacityBg")
    var activeLabels: [SKLabelNode]?
    
    private func setupPlayer(){
        
        makeCharacterTutorial(imageName: self.story?.characterAtlas)
        
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
                textScene.position = CGPoint(x: 0, y: Int(Double(frame.height)/3.5)-idx*60)
                textScene.zPosition = 100
                textScene.addStroke(color: UIColor(named: story?.labelColor ?? "") ?? textBorder, width: 7.0)
                addChild(textScene)
                activeLabels?.append(textScene)
            }
        }
        
        bgOpacity.position = CGPoint(x: 0, y: 0)
        bgOpacity.size = CGSize(width: frame.width, height: frame.width)
        bgOpacity.zPosition = 13
        bgOpacity.alpha = 0
        bgOpacity.fadeInOut(start: 2.0)
        
        addChild(bgOpacity)
        
    }
    
    func setupAnimatedShapes() {
        //Create shapes
        
        for (idx, shape) in (animateShape ?? []).enumerated() {
            let activeShape = AnimatedShape(imageName: shape.shapeImage ?? "")
            if let spriteComponent = activeShape.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: shape.xCoordinateShape, y: shape.yCoordinateShape)
                spriteComponent.node.animateUpDown(start: TimeInterval((idx+1)*2 + (idx*2)))
                spriteComponent.node.setScale(0.85)
            }
            activeShapes.append(activeShape)
            entityManager.add(activeShape)
            
            let label = SKLabelNode(text: shape.shapeName ?? "")
            
            label.fontName = "Poppins-Black"
            label.position = CGPoint(x: shape.xCoordinateFont, y: shape.yCoordinateFont)
            label.textFadeInOut(start: TimeInterval((idx+1)*2 + (idx*2)))
            label.zPosition = 15
            label.fontSize = 80
            label.fontColor = UIColor.white
            label.alpha = 0
            
            addChild(label)
            activeLabels?.append(label)
        }
    }
    
    override func didMove(to view: SKView) {
        
        // Fetch Stories Model
        entityManager = EntityManager(scene: self)
        do {
            let fetchRequest = Stories.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == 0")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "") + "_animate_2")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            fetchRequest.fetchLimit = 1
            story = try context.fetch(fetchRequest)[0]
            
            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "") + "_animate_2")
            
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
        
        // Fetch AnimatedShapes Model
        do {
            let fetchRequest = Challenges.fetchRequest()
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? ""))
            fetchRequest.predicate = challengeNamePredicate
            fetchRequest.fetchLimit = 1
            
            challenge = try context.fetch(fetchRequest)[0]
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        self.setupPlayer()
        self.setupAnimatedShapes()
    }
    
    override func getNextScene() -> SKScene? {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self, userInfo:nil)
        let scene = SKScene(fileNamed: "ShapeGameScene") as! ShapeGameScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        scene.shapeOrder = 0
        scene.level = challenge?.level ?? AttributeLevel.easy.rawValue
        return scene
    }
    
    override func getPreviousScene() -> SKScene? {
        let scene = SKScene(fileNamed: "AnimationPageScene") as! AnimationPageScene
        scene.idxScene = self.idxScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        return scene
    }
    
    override func exitScene() -> SKScene? {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self, userInfo:nil)
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
    override func willMove(from view: SKView) {
        backgroundScene.removeFromParent()
        backgroundScene.removeAllChildren()
        
        bgOpacity.removeFromParent()
        bgOpacity.removeAllChildren()
        
        for shape in self.activeShapes {
            entityManager.remove(shape)
        }
        
        for label in (self.activeLabels ?? []) as [SKLabelNode] {
            label.removeFromParent()
            label.removeAllChildren()
        }
    }
    
}
