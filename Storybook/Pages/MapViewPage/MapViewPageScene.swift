//
//  MapViewPageScene.swift
//  Storybook
//
//  Created by zy on 10/10/22.
//

import SpriteKit
import GameplayKit

class MapViewPageScene: SKScene {
    var theme: Themes?
    let backgroundSound = SKAudioNode(fileNamed: "Maps Music.mp3")
    var background: SKSpriteNode!
    var activeChallenges: [Challenge] = []
    
    var homeBtn: SKSpriteNode!
    
    
    // Entity-component system
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView) {
        print("scene size: \(size)")
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add background sound
        backgroundSound.run(SKAction.fadeIn(withDuration: 3))
        backgroundSound.autoplayLooped = true
        addChild(backgroundSound)
        
        // Add background
        background = SKSpriteNode(imageNamed: self.theme?.mapBackground ?? "")
        background.position = CGPoint(x: 0, y: 0)
        background.xScale = 1.237
        background.yScale = 1.237
        background.zPosition = -1
        addChild(background)
        
        showActiveCage()
        showHomeButton()
    }
    
    func showActiveCage() {
        for challenge in theme?.challenges?.array as! [Challenges] {
            if !(challenge.isActive) {
                continue
            }
            let activeChallenge = Challenge(imageName: challenge.background ?? "", challengeName: challenge.challengeName ?? "")
            if let spriteComponent = activeChallenge.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: challenge.xCoordinate, y: challenge.yCoordinate)
                spriteComponent.node.xScale = 1.237
                spriteComponent.node.yScale = 1.237
                spriteComponent.node.zPosition = challenge.zPosition
            }
            activeChallenges.append(activeChallenge)
            entityManager.add(activeChallenge)
        }
    }
    
    func showHomeButton() {
        homeBtn = SKSpriteNode(imageNamed: "homeButton")
        homeBtn.position = CGPoint(x: CGRectGetMinX(self.frame) + 100, y: CGRectGetMaxY(self.frame) - 100)
        addChild(homeBtn)
    }
    
    func goToScene(scene: SKScene, transition: SKTransition) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func exitScene() -> SKScene? {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self, userInfo:nil)
        let scene = SKScene(fileNamed: "HomepageScene") as! HomepageScene
        return scene
    }
    
    override func willMove(from view: SKView) {
        backgroundSound.removeAllActions()
        backgroundSound.removeFromParent()
        backgroundSound.removeAllChildren()
        
        background.removeFromParent()
        background.removeAllChildren()
        
        for challenge in activeChallenges {
            entityManager.remove(challenge)
        }
        
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            if let name = node.name, name.contains("_challenge") {
                print("aw, touches began for \(name)!")
            }
            else if node == homeBtn {
                homeBtn.run(SoundManager.sharedInstance.soundClickedButton)
                homeBtn.run(SKAction.sequence(
                    [SKAction.scale(to: 0.9, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                goToScene(scene: exitScene()!, transition: SKTransition.fade(withDuration: 1.3))
            }
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            if let name = node.name, name.contains("_challenge") {
                node.run(SoundManager.sharedInstance.soundClickedButton)
                node.run(SKAction.sequence(
                    [SKAction.scale(to: 1.0, duration: 0),
                     SKAction.scale(to: 1.237, duration: 0.1)
                    ])
                )
                
                if let scene = GKScene(fileNamed: "StartPageScene") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        // Get the SKScene from the loaded GKScene
                        if let sceneNode = scene.rootNode as! StartPageScene? {
                            // Set the scale mode to scale to fit the window
                            sceneNode.scaleMode = .aspectFill
                            sceneNode.challengeName = name
                            sceneNode.themeName = self.theme?.name ?? ""
                            // Present the scene
                            if let view = self.view {
                                view.ignoresSiblingOrder = true
                                view.showsFPS = true
                                view.showsNodeCount = true
                                view.showsDrawCount = true
                                view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1.3))
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}
