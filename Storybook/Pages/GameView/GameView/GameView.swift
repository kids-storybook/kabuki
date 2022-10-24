import Foundation
import SpriteKit
import GameplayKit

class GameView: GameScene {
    
    let backgroundScene = SKSpriteNode(imageNamed: "kandangSinga")
    var idxScene: Int32 = 0
    var challengeName: String?
    
    var story: Stories?
    
    // initialize core data context
    let context = Helper().getBackgroundContext()
    
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
        
        let rawLabels = story?.labels as? [String]
        
        if let labels = rawLabels {
            for (idx, label) in labels.enumerated() {
                let textScene = SKLabelNode(fontNamed: "Poppins-Black")
                textScene.text = label
                textScene.fontSize = 40
                textScene.fontColor = SKColor.white
                textScene.position = CGPoint(x: 0, y: -idx*40)
                textScene.zPosition = 100
                addChild(textScene)
            }
        }
        
        addChild(backgroundScene)
        
    }
    
    override func didMove(to view: SKView) {
        do {
            let fetchRequest = Stories.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == \(idxScene)")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", challengeName ?? "")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            fetchRequest.fetchLimit = 1
            story = try context.fetch(fetchRequest)[0]
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        if idxScene < 3 {
            let scene = SKScene(fileNamed: "GameView") as! GameView
            scene.idxScene = self.idxScene + 1
            scene.challengeName = self.challengeName
            return scene
        }
        // Please change this to the next scene (mini challenge, not the story anymore)
        return SKScene()
    }
    
    override func getPreviousScene() -> SKScene? {
        if idxScene > 0 {
            let scene = SKScene(fileNamed: "GameView") as! GameView
            scene.idxScene = self.idxScene - 1
            scene.challengeName = self.challengeName
            return scene
        }
        
        let scene = SKScene(fileNamed: "GameViewStart") as! GameViewStart
        scene.challengeName = self.challengeName
        return scene
    }
    
    
}
