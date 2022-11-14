import Foundation
import SpriteKit
import GameplayKit

class AppreciationPage: GameScene {
    var backgroundScene: SKSpriteNode!
    var titleImage: SKSpriteNode!
    var nextChallenge: String?
    
    private func setupPlayer(){
        
        makeCharacter(imageName: self.story?.character)
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
        titleImage = SKSpriteNode(imageNamed: self.story?.title ?? "")
        
        titleImage.position = CGPoint(x: frame.midX, y: frame.midY/2+240)
        titleImage.zPosition = 15
        
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        backgroundScene.run(SoundManager.sharedInstance.soundAppreciation[self.challengeName ?? ""] ?? SKAction())
        
        addChild(titleImage)
        addChild(backgroundScene)
        
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        continueretry = childNode(withName: "continueretry")
        retryBtn = childNode(withName: "//retryButton") as? SKSpriteNode
        continueBtn = childNode(withName: "//continueButton") as? SKSpriteNode
        
    }
    
    override func didMove(to view: SKView) {
        
        do {
            let fetchRequest = Stories.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == 0")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "" ) + "_appreciation" )
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            fetchRequest.fetchLimit = 1
            story = try context.fetch(fetchRequest)[0]
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        do {
            let fetchRequest = Challenges.fetchRequest()
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (nextChallenge ?? "" ))
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate
            ])
            fetchRequest.fetchLimit = 1
            let challenge = try context.fetch(fetchRequest)[0]
            challenge.isActive = true
            try context.save()
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
    override func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
    override func getPreviousScene() -> SKScene? {
        let scene = SKScene(fileNamed: "StartPageScene") as! StartPageScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        scene.idxScene = 0
        return scene
    }
    
    override func willMove(from view: SKView) {
        backgroundScene.removeFromParent()
        backgroundScene.removeAllChildren()
        
        titleImage.removeFromParent()
        titleImage.removeAllChildren()
    }
}
