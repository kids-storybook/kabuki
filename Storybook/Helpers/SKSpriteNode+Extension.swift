//
//  SKSpriteNode+Extension.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 27/10/22.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    
    func animateUpDown(start: TimeInterval) {
        let startTime = SKAction.wait(forDuration: start)
        let animate = SKAction.move(by: CGVector(dx: 0, dy: 100), duration: 1.5)
        let bridgeTime = SKAction.wait(forDuration: 1)
        let animate2 = SKAction.move(by: CGVector(dx: 0, dy: -100), duration: 1.5)
        let sequence = SKAction.sequence([startTime, animate, bridgeTime, animate2])
        self.run(sequence)
    }
    
    func fadeInOut(start: TimeInterval) {
        let fadeStartTime = SKAction.wait(forDuration: start)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeTime = SKAction.wait(forDuration: 11)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let sequence2 = SKAction.sequence([fadeStartTime, fadeIn, fadeTime, fadeOut])
        self.run(sequence2)
    }
    
    func buttonEffect(soundEffect: Effect){
        AudioPlayerImpl.sharedInstance.play(effect: soundEffect)
        self.run(
            SKAction.sequence([
                SKAction.scale(to: 0.9, duration: 0),
                SKAction.scale(to: 1.0, duration: 0.1)
            ])
        )
    }
    
}

