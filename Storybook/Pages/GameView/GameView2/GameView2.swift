//
//  GameView.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit

class GameView2: GameScene {
    
    let backgroundSceneViewTwo = SKSpriteNode(imageNamed: "kandangSingaZoom")
    let text = MKOutlinedLabelNode(fontNamed: "Poppins-Bold", fontSize: 40)
    var textAnimateOne = String("lingkaran")
    var textAnimateTwo = String("persegi")
    var textAnimateThree = String("segitiga")
    
    private func setupPlayer(){
        
        makeLionTutorial()
        
        backgroundSceneViewTwo.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundSceneViewTwo.zPosition = -10
        backgroundSceneViewTwo.size = self.frame.size
        
        addChild(backgroundSceneViewTwo)
        
        text.outlinedText = "Ada yang berbentuk \(textAnimateOne), \(textAnimateTwo) dan \(textAnimateThree) "
        text.borderColor = UIColor.black
        text.fontColor = UIColor.white
        text.position = CGPoint(x: 0, y: 175)
        
        addChild(text)
        
    }
    
    override func didMove(to view: SKView) {
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "GameView2") as! GameView2
    }
    
    override func getPreviousScene() -> SKScene? {
        return SKScene(fileNamed: "GameView") as! GameView
    }
    
}
