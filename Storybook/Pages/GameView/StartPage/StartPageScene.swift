import Foundation
import SpriteKit
import GameplayKit

class StartPageScene: GameScene {
    let backgroundScene = SKSpriteNode(imageNamed: "kandangSinga")
    let title = SKSpriteNode(imageNamed: "singaStoryTitle")
    
    private func setupPlayer(){
        
        makeLion()
        
        title.position = CGPoint(x: frame.midX, y: frame.midY/2+240)
        title.zPosition = 10
        
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        
        addChild(title)
        addChild(backgroundScene)
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        start = childNode(withName: "start")
        startBtn = childNode(withName: "//startButton") as? SKSpriteNode
    }
    
    override func didMove(to view: SKView) {
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
