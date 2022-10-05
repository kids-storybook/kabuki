//
//  Map.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import Foundation
import SpriteKit
import GameplayKit

class Maps: GKEntity {
    
    init(imageName: String, theme: Theme, entityManager: EntityManager) {
        
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
        addComponent(ThemeComponent(theme: theme))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

