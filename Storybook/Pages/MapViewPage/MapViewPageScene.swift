//
//  MapViewPageScene.swift
//  Storybook
//
//  Created by zy on 10/10/22.
//

import SpriteKit
import GameplayKit


class MapViewPageScene: SKScene {
    let backgroundSound = SKAudioNode(fileNamed: "bg-audio.mp3")
    
    // Entity-component system
    var entityManager: EntityManager!
    
    var data: [String: Any]?
    
    override func didMove(to view: SKView) {
        print("scene size: \(size)")
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add background sound
        backgroundSound.run(SKAction.sequence([SKAction.changeVolume(to: 0.3, duration: 0), SKAction.fadeIn(withDuration: 3)]))
        backgroundSound.autoplayLooped = true
        addChild(backgroundSound)
        
        // Add background
        let background = SKSpriteNode(imageNamed: data?["background"] as? String ?? "")
        background.position = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = -1
        addChild(background)
    }
    
    override func willMove(from view: SKView) {
        backgroundSound.removeAllActions()
    }
    
    
}
