import Foundation
import SpriteKit
import GameplayKit
import Mixpanel

class StartPageScene: GameScene {
    
    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    var titleImage: SKSpriteNode!
    
    private func setupPlayer(){
        
        makeCharacter(imageName: self.story?.characterAtlas, sound: nil)
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
        titleImage = SKSpriteNode(imageNamed: self.story?.title ?? "")
        
        titleImage.position = CGPoint(x: frame.midX, y: frame.midY/2+240)
        titleImage.zPosition = 15
        
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        
        // Add background sound
        if let music = Audio.MusicFiles.story[self.challengeName ?? ""] {
            AudioPlayerImpl.sharedInstance.play(music: music)
        }
        
        addChild(titleImage)
        addChild(backgroundScene)
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
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }
        
        self.setupPlayer()
        
        if self.theme == nil {
            self.initThemeData()
        }
    }
    
    override func getNextScene() -> SKScene? {
        Mixpanel.mainInstance().track(event: "get_story_scene", properties: ["story_name" : story?.challengeName ?? "lion_challenge"])
        let scene = SKScene(fileNamed: "StoryPageScene") as! StoryPageScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        AudioPlayerImpl.sharedInstance.play(effect: Audio.EffectFiles.animal[self.challengeName ?? ""] ?? Audio.EffectFiles.clickedButton)
        return scene
    }
    
    override func exitScene() -> SKScene? {
        AudioPlayerImpl.sharedInstance.stop()
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
