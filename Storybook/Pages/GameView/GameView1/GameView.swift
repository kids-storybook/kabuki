//
//  GameView.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit

class GameView: GameScene {
    
    var lionCub: SKSpriteNode!
    var lionMom: SKSpriteNode!
    var lionDad: SKSpriteNode!
    
    
    override func getNextScene() -> SKScene? {
      return SKScene(fileNamed: "GameView2") as! GameView2
    }
    
}
