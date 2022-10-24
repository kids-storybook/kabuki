import Foundation
import SpriteKit
import GameplayKit

class GameView: GameScene {

    let backgroundScene = SKSpriteNode(imageNamed: "kandangSinga")
    var idxScene: Int = 0
    
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
    
        let challenge_data = Theme.allGameViewAssets["challenge_1"]
        let datas = challenge_data?["scene_\(idxScene+1)"] as? [String:Any]
        let labels = datas?["labels"] as! [String]
        
        for (idx, label) in labels.enumerated() {
            let textScene = SKLabelNode(fontNamed: "Poppins-Black")
            textScene.text = label
            textScene.fontSize = 40
            textScene.fontColor = SKColor.white
            textScene.position = CGPoint(x: 0, y: -idx*40)
            textScene.zPosition = 100
            addChild(textScene)
        }
        
        addChild(backgroundScene)

    }
    
    override func didMove(to view: SKView) {
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        if idxScene < 3 {
            if let scene = GKScene(fileNamed: "GameView") {
                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene.rootNode as! GameView? {
                    // Set the scale mode to scale to fit the window
                    sceneNode.idxScene = idxScene + 1
                    return sceneNode
                }
            }
        }
        // Please change this to the next scene (mini challenge, not the story anymore)
        return SKScene()
    }
    
    override func getPreviousScene() -> SKScene? {
        if idxScene > 0 {
            if let scene = GKScene(fileNamed: "GameView") {
                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene.rootNode as! GameView? {
                    // Set the scale mode to scale to fit the window
                    sceneNode.idxScene = idxScene - 1
                    return sceneNode
                }
            }
        }
        return SKScene(fileNamed: "GameViewStart") as! GameViewStart
    }
    
    
}
