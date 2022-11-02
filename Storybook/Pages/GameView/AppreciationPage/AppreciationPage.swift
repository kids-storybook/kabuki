import Foundation
import SpriteKit
import GameplayKit

class AppreciationPage: GameScene {

    var story: Stories?
    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
//    var titleImage: SKSpriteNode!
    
    private func setupPlayer(){
        
        makeCharacter(imageName: self.story?.character)
//        setupCharacter(imageName: self.story?.character)
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
//        titleImage = SKSpriteNode(imageNamed: self.story?.title ?? "")
        
//        titleImage.position = CGPoint(x: frame.midX, y: frame.midY/2+240)
//        titleImage.zPosition = 15
        
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        
//        addChild(titleImage)
        addChild(backgroundScene)
        
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        continueRetry = childNode(withName: "continueRetry")
        retryButton = childNode(withName: "//retryButton") as? SKSpriteNode
        continueButton = childNode(withName: "//continueButton") as? SKSpriteNode
        start = childNode(withName: "start")
        startBtn = childNode(withName: "//startButton") as? SKSpriteNode
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
        if self.theme == nil {
            self.initThemeData()
        }
    }
    
    override func getNextScene() -> SKScene? {
        let scene = SKScene(fileNamed: "StoryPageScene") as! StoryPageScene
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
