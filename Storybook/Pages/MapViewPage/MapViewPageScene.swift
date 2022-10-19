//
//  MapViewPageScene.swift
//  Storybook
//
//  Created by zy on 10/10/22.
//

import SpriteKit
import GameplayKit


class MapViewPageScene: SKScene {
    let backgroundSound = SKAudioNode(fileNamed: "Maps Music.mp3")
    
    // Entity-component system
    var entityManager: EntityManager!
    
    var data: [String: Any]?
    
    
    override func didMove(to view: SKView) {
        print("scene size: \(size)")
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add background sound
        backgroundSound.run(SKAction.fadeIn(withDuration: 3))
        backgroundSound.run(SKAction.changeVolume(to: 0.3, duration: 3))
        backgroundSound.autoplayLooped = true
        addChild(backgroundSound)
        
        // Add background
        let background = SKSpriteNode(imageNamed: data?["background"] as? String ?? "")
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
            let challenge = Challenge(imageName: challengeData?["background"] as? String ?? "", challengeName: "challange_\(idx)")
            let location = challengeData?["location"] as? Array<Double>
            if let spriteComponent = challenge.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: location?[0] ?? 0.0, y: location?[1] ?? 0.0)
                spriteComponent.node.xScale = 1.237
                spriteComponent.node.yScale = 1.237
                spriteComponent.node.zPosition = challengeData?["zPosition"] as? Double ?? 0.0
            }
            entityManager.add(challenge)
        }
    }
    
    override func willMove(from view: SKView) {
        backgroundSound.removeAllActions()
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            if let name = node.name, name.contains("challenge_") {
                print(name)
                print("aw, touches began!")
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
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}
