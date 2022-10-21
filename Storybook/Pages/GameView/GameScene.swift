//
//  GameView.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var header: SKNode!
    var footer: SKNode!
    var nxtBtn: SKSpriteNode!
    var prevBtn: SKSpriteNode!
    var exitBtn: SKSpriteNode!
    var entityManager: EntityManager!
    
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
    
    func exitScene() -> SKScene? {
        return nil
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        footer = childNode(withName: "footer")
        header = childNode(withName: "header")
        nxtBtn = childNode(withName: "//nextButton") as? SKSpriteNode
        prevBtn = childNode(withName: "//previousButton") as? SKSpriteNode
        exitBtn = childNode(withName: "//exitButton") as? SKSpriteNode
    }
    
    func goToScene(scene: SKScene, transitionDirection: SKTransitionDirection) {
        let sceneTransition = SKTransition.push(with: transitionDirection, duration: 1.5)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: sceneTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if footer.contains(touchLocation) {
            let location = touch.location(in: footer)
            
            if nxtBtn.contains(location) {
                nxtBtn.run(SoundManager.sharedInstance.soundClickedButton)
                goToScene(scene: getNextScene()!, transitionDirection: SKTransitionDirection.left)
            }
            else if prevBtn.contains(location) {
                prevBtn.run(SoundManager.sharedInstance.soundClickedButton)
                goToScene(scene: getPreviousScene()!, transitionDirection: SKTransitionDirection.right)
            }
            
        } else if header.contains(touchLocation){
            let location = touch.location(in: header)
            
            if exitBtn.contains(location) {
                goToScene(scene: exitScene()!)
//                print("exit dipencet")
            }
            
        } else {
            
            // 4
            touchDown(at: touchLocation)
        }
        
    }
    
    override func didMove(to view: SKView) {
    }
}
