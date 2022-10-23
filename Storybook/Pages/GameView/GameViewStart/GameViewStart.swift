import Foundation
import SpriteKit
import GameplayKit

class GameViewStart: GameScene {
    
    var start: SKNode!
    var startBtn: SKSpriteNode!
    let backgroundScene = SKSpriteNode(imageNamed: "kandangSinga")
    var challengeName: String?
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if start.contains(touchLocation) {
            let location = touch.location(in: start)
            let node = atPoint(location)
            node.run(SoundManager.sharedInstance.soundClickedButton)
            if startBtn.contains(location) {
                goToScene(scene: getNextScene()!, transitionDirection: SKTransitionDirection.left)
            }
            
        } else if header.contains(touchLocation) {
            let location = touch.location(in: header)
            
            if exitBtn.contains(location) {
                goToScene(scene: exitScene()!)
                
            }
            
        } else {
            touchDown(at: touchLocation)
        }
    }
    
    override func getNextScene() -> SKScene? {
        let scene = SKScene(fileNamed: "GameView") as! GameView
        scene.challengeName = self.challengeName
        return scene
    }

    override func exitScene() -> SKScene? {
        return SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
    }
}
