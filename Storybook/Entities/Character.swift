import SpriteKit
import GameplayKit

// 1
class Character: GKEntity {
    
    var story: Stories?
    
    init(imageName: String) {
        super.init()
        
        // 2
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        
        spriteComponent.node.size = CGSize(width: story?.characterWidth ?? 0.0, height: story?.characterHeight ?? 0.0)
        spriteComponent.node.position = CGPoint(x: story?.characterXPosition ?? 0.0, y: story?.characterYPosition ?? 0.0)
        
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
