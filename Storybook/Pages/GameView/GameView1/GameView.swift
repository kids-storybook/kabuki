import Foundation
import SpriteKit

class GameView: GameScene {

    let backgroundSceneViewOne = SKSpriteNode(imageNamed: "kandangSinga")
    
    private func setupPlayer(){
        
        entityManager = EntityManager(scene: self)
        
        let lionCub = Lion(imageName: "#1 Anak Singa")
        if let spriteComponent = lionCub.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.frame.midX/2+25, y: spriteComponent.node.frame.midY/2-85)
            spriteComponent.node.size = CGSize(width: 550, height: 550)
            spriteComponent.node.zPosition = 10
        }
        
        let lionMom = Lion(imageName: "#1 Female Lion")
        if let spriteComponent = lionMom.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.frame.midX/2+180, y: -spriteComponent.node.frame.midY/2-45)
            spriteComponent.node.size = CGSize(width: 550, height: 550)
            spriteComponent.node.zPosition = 5
        }

        let lionDad = Lion(imageName: "#1 Lion")
        if let spriteComponent = lionDad.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: -spriteComponent.node.frame.midX/2-195, y: -spriteComponent.node.frame.midY/2-35)
            spriteComponent.node.size = CGSize(width: 600, height: 600)
            spriteComponent.node.zPosition = 5
        }
        
        entityManager.add(lionCub)
        entityManager.add(lionMom)
        entityManager.add(lionDad)
        
        backgroundSceneViewOne.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundSceneViewOne.zPosition = -10
    
        textScene.text = "Lihatlah keluarga singa ini"
        textScene.fontSize = 40
        textScene.fontColor = SKColor.white
        textScene.position = CGPoint(x: 0, y: 0)
        textScene.zPosition = 100
        
        addChild(backgroundSceneViewOne)
        addChild(textScene)

    }
    
    override func didMove(to view: SKView) {
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "GameView2") as! GameView2
    }
    
    override func getPreviousScene() -> SKScene? {
        return SKScene(fileNamed: "GameViewStart") as! GameViewStart
    }
    
    
    
    
}
