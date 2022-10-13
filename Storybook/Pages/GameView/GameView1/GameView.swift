//
//  GameView.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit

class GameView: GameScene {
    
    let lionCub = SKSpriteNode(imageNamed: "anakSinga")
    let lionMom = SKSpriteNode(imageNamed: "ibuSinga")
    let lionDad = SKSpriteNode(imageNamed: "bapakSinga")
    let backgroundScene = SKSpriteNode(imageNamed: "GameBgImg")
    let nextBtn = SKSpriteNode(imageNamed: "nextBtn")

    private func setupPlayer(){
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        
        lionCub.position = CGPoint(x: frame.midX, y: -frame.midY/2-200)
        lionCub.size = CGSize(width: 580, height: 405)
        
        lionMom.position = CGPoint(x: frame.midX/2+200, y: -frame.midY/2-125)
        lionMom.size = CGSize(width: 380, height: 452)
        
        lionDad.position = CGPoint(x: -frame.midX/2-100, y: -frame.midY/2-100)
        lionDad.size = CGSize(width: 585, height: 453)
        
        nextBtn.position = CGPoint(x: frame.maxX-100, y: -frame.maxY/2-100)
        nextBtn.size = CGSize(width: 50, height: 68)
        
        addChild(backgroundScene)
        addChild(lionCub)
        addChild(lionMom)
        addChild(lionDad)
        addChild(nextBtn)
        
    }
    
    override func didMove(to view: SKView) {
        self.setupPlayer()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        if let location = touch?.location(in: self) {
            if nextBtn.contains(location) {
                goToScene(scene: getNextScene()!)
            }
        }
        
    }
    
    override func getNextScene() -> SKScene? {
      return SKScene(fileNamed: "GameView2") as! GameView2
    }
    
    
    
}