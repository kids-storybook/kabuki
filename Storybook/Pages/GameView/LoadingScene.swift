import Foundation
import SpriteKit

class LoadingScene: GameScene {
    
    var timer = Timer()
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint (x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        self.addChild(background)
        //Create a Scheduled timer thats will fire a function after the timeInterval
        timer = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self,
                                     selector: #selector(presentNewScene),
                                     userInfo: nil, repeats: false)
    }
    
    @objc func presentNewScene() {
        //Configure the new scene to be presented and then present.
        let newScene = SKScene(size: .zero)
        view?.presentScene(newScene)
    }
    
    deinit {
        //Stops the timer.
        timer.invalidate()
    }
    
}
