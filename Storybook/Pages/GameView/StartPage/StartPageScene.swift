import Foundation
import SpriteKit
import GameplayKit

class StartPageScene: GameScene {

    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    var titleImage: SKSpriteNode!
    var characterFrames : [SKTexture] = []
    
    private var characterAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: story?.characterAtlas ?? "")
    }
    
    private var characterTexture: SKTexture {
        return characterAtlas.textureNamed("\(story?.characterAtlas ?? "")1")
    }
    
    private var characterIdleTexture: [SKTexture] {
        
        var index: [SKTexture] = []
        let numImages = characterAtlas.textureNames.count
        
        for i in 1...numImages {
            let textureNames = characterAtlas.textureNamed("\(story?.characterAtlas ?? "")\(i)")
            index.append(textureNames)
        }
        
        characterFrames = index
        return characterFrames
        
    }
    
    private func setupPlayer(){
        
//        makeCharacter(imageName: self.story?.character)
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
        titleImage = SKSpriteNode(imageNamed: self.story?.title ?? "")
        
        titleImage.position = CGPoint(x: frame.midX, y: frame.midY/2+240)
        titleImage.zPosition = 15
        
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        
        // Add background sound
        let soundPayload: [String: Any] = ["fileToPlay" : "Story Music-\(self.challengeName ?? "")", "isKeepToPlay": true ]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PlayBackgroundSound"), object: self, userInfo:soundPayload)
        
        // Add animated character
        characterAnimated = SKSpriteNode(texture: characterTexture, size: CGSize(width: 913, height: 613))
        characterAnimated.position = CGPoint(x: frame.midX, y: frame.midY)
        characterAnimated.zPosition = 20
        
        addChild(titleImage)
        addChild(backgroundScene)
        addChild(characterAnimated)
        print("Character Atlas : \(characterAtlas)")
    }
    
    func startIdleAnimation() {
        let idleAnimation = SKAction.animate(with: characterIdleTexture, timePerFrame: 0.2)
        characterAnimated.run(SKAction.repeatForever(idleAnimation), withKey: "chracterIdleAnimation")
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
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
            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", challengeName ?? "")
            totalStories = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        self.setupPlayer()
        self.startIdleAnimation()
        
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
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self, userInfo:nil)
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
    override func willMove(from view: SKView) {
        backgroundScene.removeFromParent()
        backgroundScene.removeAllChildren()
        
        titleImage.removeFromParent()
        titleImage.removeAllChildren()
    }
}
