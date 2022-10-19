//
//  Challenge.swift
//  Storybook
//
//  Created by zy on 18/10/22.
//

import Foundation
import SpriteKit
import GameplayKit

class Challenge: GKEntity {
    init(imageName: String, challengeName: String) {
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        
        spriteComponent.node.name = challengeName
        spriteComponent.node.zPosition = 0
        
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


