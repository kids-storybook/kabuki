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
    init(themeAssets: [String:String], mapName: String,  mapPosition: CGPoint, frame: CGRect) {
        super.init()
        
        let texture = SKTexture(imageNamed: themeAssets["background"]!)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        
        spriteComponent.node.name = mapName
        spriteComponent.node.position = mapPosition
        spriteComponent.node.zPosition = 0
        
        // Add start button + label for each map
        let startButton = SKSpriteNode(imageNamed: themeAssets["startButton"]!)
        startButton.position = CGPoint(x: frame.midX, y: spriteComponent.node.frame.minY - (spriteComponent.node.frame.minY*0.2))
        startButton.zPosition = 1
        spriteComponent.node.addChild(startButton)
        
        let labelMap = SKSpriteNode(imageNamed: themeAssets["label"]!)
        labelMap.position = CGPoint(x: frame.midX, y: spriteComponent.node.frame.maxY + (spriteComponent.node.frame.maxY*0.4))
        labelMap.zPosition = 1
        spriteComponent.node.addChild(labelMap)
        
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

