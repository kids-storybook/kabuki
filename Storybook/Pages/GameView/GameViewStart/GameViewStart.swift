import Foundation
import SpriteKit

class GameViewStart: GameScene {
    
    var start: SKNode!
    var startBtn: SKSpriteNode!
    let backgroundScene = SKSpriteNode(imageNamed: "kandangSinga")
    
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
        
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        
        addChild(backgroundScene)
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        start = childNode(withName: "start")
        startBtn = childNode(withName: "//startButton") as? SKSpriteNode
    }
    
    override func didMove(to view: SKView) {
        self.setupPlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if start.contains(touchLocation) {
            let location = touch.location(in: start)
            
            if startBtn.contains(location) {
                goToScene(scene: getNextScene()!)
            }
            
        } else {
            touchDown(at: touchLocation)
        }
    }
    
    override func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "GameView") as! GameView
    }
    
    
    
}