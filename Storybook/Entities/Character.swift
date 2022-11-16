import SpriteKit
import GameplayKit

// 1
class Character: GKEntity {
    
    init(imageName: String, sound: SKAction) {
        super.init()
        
        var characterAtlas: SKTextureAtlas {
            return SKTextureAtlas(named: imageName)
        }
        
        var characterTexture: SKTexture {
            return characterAtlas.textureNamed("\(imageName)0")
        }
        
        var characterIdleTexture: [SKTexture] {
            
            var index: [SKTexture] = []
            let imagesName = characterAtlas.textureNames
            
            for name in imagesName {
                let textureNames = characterAtlas.textureNamed(name)
                index.append(textureNames)
                print("index: \(index)")
            }
            return index
            
        }
        
        // 2
        let spriteComponent = SpriteComponent(entity: self, texture: characterTexture, size: characterTexture.size(), sound:sound)
        addComponent(spriteComponent)
        
        let idleAnimation = SKAction.animate(with: characterIdleTexture, timePerFrame: 0.2)
        spriteComponent.node.run(SKAction.repeatForever(idleAnimation), withKey: "chracterIdleAnimation")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
