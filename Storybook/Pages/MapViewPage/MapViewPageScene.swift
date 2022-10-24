//
//  MapViewPageScene.swift
//  Storybook
//
//  Created by zy on 10/10/22.
//

import SpriteKit
import GameplayKit

class MapViewPageScene: SKScene {
    var data: [String: Any]?
    let backgroundSound = SKAudioNode(fileNamed: "Maps Music.mp3")
    var background: SKSpriteNode!
    var activeChallenges: [Challenge] = []
    
    // Entity-component system
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView) {
        print("scene size: \(size)")
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add background sound
        backgroundSound.run(SKAction.fadeIn(withDuration: 3))
        backgroundSound.autoplayLooped = true
//        addChild(backgroundSound)
        
        // Add background
        background = SKSpriteNode(imageNamed: self.data?["background"] as? String ?? "")
        background.position = CGPoint(x: 0, y: 0)
        background.xScale = 1.237
        background.yScale = 1.237
        background.zPosition = -1
        addChild(background)
        
        showActiveCage()
    }
    
    func showActiveCage() {
        for idx in 1...7 {
            let challengeData = data?["challenge_\(idx)"] as? [String:Any]
            if !(challengeData?["isActive"] as? Bool ?? false) {
                continue
            }
            let challenge = Challenge(imageName: challengeData?["background"] as? String ?? "", challengeName: "challenge_\(idx)")
            let location = challengeData?["location"] as? Array<Double>
            if let spriteComponent = challenge.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: location?[0] ?? 0.0, y: location?[1] ?? 0.0)
                spriteComponent.node.xScale = 1.237
                spriteComponent.node.yScale = 1.237
                spriteComponent.node.zPosition = challengeData?["zPosition"] as? Double ?? 0.0
            }
            activeChallenges.append(challenge)
            entityManager.add(challenge)
        }
    }
    
    override func willMove(from view: SKView) {
        backgroundSound.removeAllActions()
        backgroundSound.removeFromParent()
        backgroundSound.removeAllChildren()
        
        background.removeFromParent()
        background.removeAllChildren()
        
        for challenge in activeChallenges {
            print("BYE GUYS")
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
            if let name = node.name, name.contains("challenge_") {
                print("aw, touches began for \(name)!")
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
            if let name = node.name, name.contains("challenge_") {
                node.run(SoundManager.sharedInstance.soundClickedButton)
                node.run(SKAction.sequence(
                    [SKAction.scale(to: 1.5, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                
                if let scene = GKScene(fileNamed: "GameViewStart") {
                    // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! GameViewStart? {
                        // Set the scale mode to scale to fit the window
                        sceneNode.scaleMode = .aspectFill
                        // Present the scene
                        if let view = self.view {
                            view.ignoresSiblingOrder = true
                            view.showsFPS = true
                            view.showsNodeCount = true
                            view.showsDrawCount = true
                            view.presentScene(sceneNode, transition: SKTransition.push(with: SKTransitionDirection.left, duration: 1.5))
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
