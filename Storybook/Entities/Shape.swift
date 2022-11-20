//
//  Shape.swift
//  Storybook
//
//  Created by zy on 27/10/22.
//

import Foundation
import SpriteKit
import GameplayKit

class Shape: GKEntity {
    init(imageName: String, shapeName: String, sound: Effect?) {
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size(), sound: sound)
        
        spriteComponent.node.name = shapeName
        spriteComponent.node.zPosition = 0
        
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
