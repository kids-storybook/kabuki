import Foundation
import SpriteKit
import GameplayKit

class AppreciationPage: GameScene {

    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    var titleImage: SKSpriteNode!
    
    private func setupPlayer(){
        
        makeCharacter(imageName: self.story?.character)
//        setupCharacter(imageName: self.story?.character)
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
        titleImage = SKSpriteNode(imageNamed: self.story?.title ?? "")
        
        titleImage.position = CGPoint(x: frame.midX, y: frame.midY/2+240)
        titleImage.zPosition = 15
        
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        
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
//            print("Data \(story?.background)")
            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "") + "_appreciation")
            totalStories = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        self.setupPlayer()
//        if self.theme == nil {
//            self.initThemeData()
//        }
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
        
        if idxScene > 0 {
            let scene = SKScene(fileNamed: "AppreciationPage") as! AppreciationPage
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
}
