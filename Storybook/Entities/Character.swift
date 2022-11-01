import SpriteKit
import GameplayKit

// 1
class Character: GKEntity {
    
    init(imageName: String) {
        super.init()
        
        // 2
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
