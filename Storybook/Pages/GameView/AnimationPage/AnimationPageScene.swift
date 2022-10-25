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
    
    let backgroundSceneViewTwo = SKSpriteNode(imageNamed: "kandangSingaZoom")
    //    let text = MKOutlinedLabelNode(fontNamed: "Poppins-Bold", fontSize: 40)
    let text = SKLabelNode(text: "Hello")
    var textAnimateOne = String("lingkaran")
    var textAnimateTwo = String("persegi")
    var textAnimateThree = String("segitiga")
    var story: Stories?
    var totalStories: Int?
    
    private func setupPlayer(){
        
        makeLionTutorial()
        
        backgroundSceneViewTwo.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundSceneViewTwo.zPosition = -10
        backgroundSceneViewTwo.size = self.frame.size
        
        addChild(backgroundSceneViewTwo)
        
        let rawLabels = story?.labels as? [String]
        
        if let labels = rawLabels {
            for (idx, label) in labels.enumerated() {
                let textScene = SKLabelNode(fontNamed: "Poppins-Black")
                textScene.text = label
                textScene.fontSize = 50
                textScene.fontColor = SKColor.white
                textScene.position = CGPoint(x: 0, y: Int(frame.height)/3-idx*40)
                textScene.zPosition = 100
                textScene.addStroke(color: textBorder, width: 7.0)
                addChild(textScene)
            }
        }
    }
    
    override func didMove(to view: SKView) {
        do {
            let fetchRequest = Stories.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == \(idxSceneAnimate)")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "") + "_animate")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            fetchRequest.fetchLimit = 1
            story = try context.fetch(fetchRequest)[0]
            
            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", challengeName ?? "")
            totalStories = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        if Int(idxSceneAnimate) < totalStories ?? 0 {
            let scene = SKScene(fileNamed: "AnimationPageScene") as! AnimationPageScene
            scene.idxSceneAnimate = self.idxSceneAnimate + 1
            scene.challengeName = self.challengeName
            scene.theme = self.theme
            return scene
        }
        let scene = SKScene(fileNamed: "StartPageScene") as! StartPageScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        return scene
    }
    
    override func getPreviousScene() -> SKScene? {
        if idxSceneAnimate > 0 {
            let scene = SKScene(fileNamed: "AnimationPageScene") as! AnimationPageScene
            scene.idxSceneAnimate = self.idxSceneAnimate - 1
            scene.challengeName = self.challengeName
            scene.theme = self.theme
            return scene
        }
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
