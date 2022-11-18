//
//  SplashScreen.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 17/11/22.
//

import Foundation
import SpriteKit

class SplashScreen : SKScene {
    
    var splashscreen: SKNode!
    var background: SKSpriteNode!
    
    override func sceneDidLoad() {
        splashscreen = childNode(withName: "SplashScreen")
        background = childNode(withName: "background") as? SKSpriteNode
    }
    
    override func didMove(to view: SKView) {
        background.zPosition = 10
        
        addChild(background)
    }
    
}
