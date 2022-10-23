import Foundation
import SpriteKit

class GameView: GameScene {

    let backgroundSceneViewOne = SKSpriteNode(imageNamed: "kandangSinga")
    
    private func setupPlayer(){
        
        makeLion()
        
        backgroundSceneViewOne.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundSceneViewOne.zPosition = -10
        backgroundSceneViewOne.size = self.frame.size
    
        textScene.text = "Lihatlah keluarga singa ini"
        textScene.fontSize = 40
        textScene.fontColor = SKColor.white
        textScene.position = CGPoint(x: 0, y: 0)
        textScene.zPosition = 100
        
        addChild(backgroundSceneViewOne)
        addChild(textScene)

    }
    
    override func didMove(to view: SKView) {
        self.setupPlayer()
    }
    
    override func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "GameView2") as! GameView2
    }
    
    override func getPreviousScene() -> SKScene? {
        return SKScene(fileNamed: "GameViewStart") as! GameViewStart
    }
    
    
    
    
}
