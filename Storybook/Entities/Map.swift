//
//  Map.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import Foundation
import SpriteKit
import GameplayKit

class Map: GKEntity {
    init(themeAssets: Themes, mapName: String,  mapPosition: CGPoint, frame: CGRect) {
        super.init()
        
        let texture = SKTexture(imageNamed: themeAssets.background ?? "")
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        
        spriteComponent.node.name = mapName
        spriteComponent.node.position = mapPosition
        spriteComponent.node.zPosition = 0
        
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

