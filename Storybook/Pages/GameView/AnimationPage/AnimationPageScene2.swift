//
//  AnimationPageScene.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit
import UIKit

class AnimationPageScene2: GameScene {
    
    var story: Stories?
    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    var box = SKSpriteNode(imageNamed: "Box")
    var cone = SKSpriteNode(imageNamed: "Cone")
    var ball = SKSpriteNode(imageNamed: "Ball")
    var bgOpacity = SKSpriteNode(imageNamed: "opacityBg")
    
    private func setupPlayer(){
        
        makeLionTutorial()
        
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
        
        box.position = CGPoint(x: -265, y: -245)
        box.zPosition = 15
        box.size = CGSize(width: 178, height: 191)
        
        cone.position = CGPoint(x: -25, y: -250)
        cone.zPosition = 15
        cone.size = CGSize(width: 208, height: 194)
        
        ball.position = CGPoint(x: 204, y: -235)
        ball.zPosition = 15
        ball.size = CGSize(width: 198, height: 217)
        
        bgOpacity.position = CGPoint(x: 0, y: 0)
        bgOpacity.zPosition = 13
        bgOpacity.alpha = 0
        
        box.animateUpDown(start: 3.0)
        cone.animateUpDown(start: 7.5)
        ball.animateUpDown(start: 12)
        bgOpacity.fadeInOut(start: 3.0)
        
        addChild(box)
        addChild(cone)
        addChild(ball)
        addChild(bgOpacity)
        
        
    }
    
    override func didMove(to view: SKView) {
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
        
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
//        if Int(idxSceneAnimate) < totalStories ?? 0 {
//            let scene = SKScene(fileNamed: "AnimationPageScene") as! AnimationPageScene
////            scene.idxSceneAnimate = self.idxSceneAnimate + 1
//            scene.challengeName = self.challengeName
//            scene.theme = self.theme
//            return scene
//        }
        let scene = SKScene(fileNamed: "StartPageScene") as! StartPageScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        scene.idxScene = self.idxScene
        return scene
    }
    
    override func getPreviousScene() -> SKScene? {
//        if idxSceneAnimate > 0 {
//            let scene = SKScene(fileNamed: "AnimationPageScene2") as! AnimationPageScene2
////            scene.idxSceneAnimate = self.idxSceneAnimate - 1
//            scene.challengeName = self.challengeName
//            scene.theme = self.theme
//            return scene
//        }
        let scene = SKScene(fileNamed: "AnimationPageScene") as! AnimationPageScene
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
