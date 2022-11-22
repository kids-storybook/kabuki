//
//  Background.swift
//  Storybook
//
//  Created by zy on 20/11/22.
//

import Foundation
import SpriteKit
import GameplayKit

class Background: GKEntity {
    init(imageName: String) {
        super.init()

        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size(), sound: nil)

        spriteComponent.node.zPosition = -10
        spriteComponent.node.position = CGPoint(x: 0, y: 0)

        addComponent(spriteComponent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
