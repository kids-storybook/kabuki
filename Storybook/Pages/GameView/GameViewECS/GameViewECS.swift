import SpriteKit
import Foundation

class GameViewECS: GameScene {
    
    override func didMove(to view: SKView) {

        entityManager = EntityManager(scene: self)
        
        let lionCub = Lion(imageName: "anakSinga")
        if let spriteComponent = lionCub.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.frame.midX, y: spriteComponent.node.frame.midY/2-200)
        }
        
        entityManager.add(lionCub)

        
    }
    
}
