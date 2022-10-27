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
    
    private func setupPlayer(){
        
        makeLionTutorial()
        
        backgroundSceneViewTwo.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundSceneViewTwo.zPosition = -10
        backgroundSceneViewTwo.size = self.frame.size
        
        addChild(backgroundSceneViewTwo)
        
        //        text.outlinedText = "Ada yang berbentuk \(textAnimateOne), \(textAnimateTwo) dan \(textAnimateThree) "
        
        text.fontColor = UIColor.white
        text.position = CGPoint(x: 0, y: 175)
        text.zPosition = 15
        text.preferredMaxLayoutWidth = 700
        text.numberOfLines = 2
        //        text.attributedText =
        
        //        let attributes: [NSAttributedString.Key: Any] = [
        //            .strokeWidth: 5.0,
        //            .strokeColor: UIColor.black
        //        ]
        
        //        let attributedString = NSAttributedString(string: text, attributes: attributes)
        
        //        text.horizontalAlignmentMode = .center
        
        addChild(text)
    }
    
    override func didMove(to view: SKView) {
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MiniGameView") as! MiniGameView
        scene.challengeName = self.challengeName
        return scene
    }
    
    override func getPreviousScene() -> SKScene? {
        let scene = SKScene(fileNamed: "StoryPageScene") as! StoryPageScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        scene.idxScene = self.idxScene
        return scene
    }
    
    override func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
}
