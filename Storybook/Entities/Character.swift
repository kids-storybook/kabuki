import SpriteKit
import GameplayKit

// 1
class Character: GKEntity {
    
    init(imageName: String) {
        super.init()
        
        var characterAtlas: SKTextureAtlas {
            return SKTextureAtlas(named: imageName)
        }
        
        var characterTexture: SKTexture {
            return characterAtlas.textureNamed("\(imageName)0")
        }
        
        var characterIdleTexture: [SKTexture] {
            
            var index: [SKTexture] = []
//            let numImages = characterAtlas.textureNames.count
            
            for i in 0...4 {
                let textureNames = characterAtlas.textureNamed("\(imageName)\(i)")
                index.append(textureNames)
                print("index: \(index)")
            }
            return index
            
        }
        
        // 2
        let spriteComponent = SpriteComponent(entity: self, texture: characterTexture, size: characterTexture.size())
        addComponent(spriteComponent)
        
        let idleAnimation = SKAction.animate(with: characterIdleTexture, timePerFrame: 0.2)
        spriteComponent.node.run(SKAction.repeatForever(idleAnimation), withKey: "chracterIdleAnimation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
