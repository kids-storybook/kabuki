//
//  GameView.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit

class GameView2: GameScene {
    let referenceFooter = SKReferenceNode(fileNamed: "Footer")!
    
    override func didMove(to view: SKView) {
        referenceFooter.name = "footer"
        referenceFooter.position = CGPoint(x: frame.midX, y: frame.minY+100)
        print("CEK COBA")
        print(referenceFooter)
        addChild(referenceFooter)
    }
 
}
