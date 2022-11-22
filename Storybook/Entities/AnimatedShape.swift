import Foundation
import SpriteKit
import GameplayKit

class AnimatedShape: GKEntity {
    init(imageName: String, sound: Effect?) {
        super.init()

        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size(), sound: sound)

        spriteComponent.node.zPosition = 15

        addComponent(spriteComponent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
