import Foundation
import SpriteKit

class GameView: GameScene {

    let backgroundScene = SKSpriteNode(imageNamed: "kandangSinga")
    
    private func setupPlayer(){
        
        entityManager = EntityManager(scene: self)
        
        let lionCub = Lion(imageName: "anakSinga")
        if let spriteComponent = lionCub.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.frame.midX, y: spriteComponent.node.frame.midY/2-200)
            spriteComponent.node.size = CGSize(width: 580, height: 405)
        }
        
        let lionMom = Lion(imageName: "ibuSinga")
        if let spriteComponent = lionMom.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.frame.midX/2+200, y: -spriteComponent.node.frame.midY/2-125)
            spriteComponent.node.size = CGSize(width: 380, height: 452)
        }

        let lionDad = Lion(imageName: "bapakSinga")
        if let spriteComponent = lionDad.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: -spriteComponent.node.frame.midX/2-100, y: -spriteComponent.node.frame.midY/2-100)
            spriteComponent.node.size = CGSize(width: 585, height: 453)
        }
        
        entityManager.add(lionCub)
        entityManager.add(lionMom)
        entityManager.add(lionDad)
        
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        
        addChild(backgroundScene)

    }
    
    override func didMove(to view: SKView) {
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "GameView2") as! GameView2
    }
    
    
    
}
