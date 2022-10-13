//
//  GameView.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var footer: SKNode!
    var nxtBtn: SKSpriteNode!
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchMoved(to: touch.location(in: self))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchUp(at: touch.location(in: self))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchUp(at: touch.location(in: self))
    }
    
    // MARK:- Stub methods - override these in sub classes
    func touchDown(at point: CGPoint) {}
    func touchMoved(to point: CGPoint) {}
    func touchUp(at point: CGPoint) {}
    func getNextScene() -> SKScene? {
        return nil
    }
    func getPreviousScene() -> SKScene? {
        return nil
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        footer = childNode(withName: "footer")
        nxtBtn = childNode(withName: "//nextButton") as? SKSpriteNode
    }
    
    func goToScene(scene: SKScene) {
        let sceneTransition = SKTransition.fade(with: UIColor.darkGray, duration: 1)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: sceneTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        // 1
        let touchLocation = touch.location(in: self)
        
        // 2
        if footer.contains(touchLocation) {
            let location = touch.location(in: footer)
            
            // 3
            if nxtBtn.contains(location) {
                goToScene(scene: getNextScene()!)
            }
            
        } else {
            
            // 4
            touchDown(at: touchLocation)
        }
    }
    
}
