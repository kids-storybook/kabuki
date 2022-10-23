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
        makeLion()

        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        
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
