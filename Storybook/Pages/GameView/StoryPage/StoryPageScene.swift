import Foundation
import SpriteKit
import GameplayKit

class StoryPageScene: GameScene {
    
    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    var activeLabels: [SKLabelNode]?
    
    private func setupPlayer(){
        makeCharacter(imageName: self.story?.characterAtlas, sound: SoundManager.sharedInstance.soundOfAnimal[self.challengeName ?? ""] ?? SKAction())
        entityManager = EntityManager(scene: self)
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
        
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
                textScene.position = CGPoint(x: 0, y: Int(Double(frame.height)/3.5)-idx*60)
                textScene.zPosition = 100
                textScene.addStroke(color: UIColor(named: story?.labelColor ?? "") ?? textBorder, width: 7.0)
                addChild(textScene)
                activeLabels?.append(textScene)
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
            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", challengeName ?? "")
            totalStories = try context.count(for: fetchRequest)
        } catch let error as NSError {
            DispatchQueue.main.async {
                let ac = UIAlertController(title: error.localizedDescription, message: "Oops, there is error while fetching data.", preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "exit", style: .cancel){(action) in exit(0)})
                
                self.view?.window?.rootViewController!.present(ac, animated: true, completion: nil)
            }
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
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self, userInfo:nil)
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
    override func willMove(from view: SKView) {
        backgroundScene.removeFromParent()
        backgroundScene.removeAllChildren()
        
        for label in (self.activeLabels ?? []) as [SKLabelNode] {
            label.removeFromParent()
            label.removeAllChildren()
        }
    }
}
