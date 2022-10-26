import Foundation
import SpriteKit
import GameplayKit

class StoryPageScene: GameScene {
    
    var story: Stories?
    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    
    private func setupPlayer(){
        makeLion()
        entityManager = EntityManager(scene: self)
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
//        backgroundScene = SKSpriteNode(imageNamed: "kandangSingaZoom")
        
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        
        let rawLabels = story?.labels as? [String]
        
        if let labels = rawLabels {
            for (idx, label) in labels.enumerated() {
                let textScene = SKLabelNode(fontNamed: "Poppins-Black")
                textScene.text = label
                textScene.fontSize = 50
                textScene.fontColor = SKColor.white
                textScene.position = CGPoint(x: 0, y: Int(frame.height)/3-idx*60)
                textScene.zPosition = 100
                textScene.addStroke(color: textBorder, width: 7.0)
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
//            print("Data \(story?.background)")
            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", challengeName ?? "")
            totalStories = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        if Int(idxScene) < totalStories ?? 0 {
            let scene = SKScene(fileNamed: "StoryPageScene") as! StoryPageScene
            scene.idxScene = self.idxScene + 1
            scene.challengeName = self.challengeName
            scene.theme = self.theme
            return scene
        }
        let scene = SKScene(fileNamed: "AnimationPageScene") as! AnimationPageScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        scene.idxScene = self.idxScene
        return scene
    }
    
    override func getPreviousScene() -> SKScene? {
        if idxScene > 0 {
            let scene = SKScene(fileNamed: "StoryPageScene") as! StoryPageScene
            scene.idxScene = self.idxScene - 1
            scene.challengeName = self.challengeName
            scene.theme = self.theme
            return scene
        }
        
        let scene = SKScene(fileNamed: "StartPageScene") as! StartPageScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        return scene
    }
    
    override func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
}
