//
//  Gamescene+Extension.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 09/11/22.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    
    func makeCharacter(imageName: String?, sound: Effect?) {
        
        entityManager = EntityManager(scene: self)
        
        character = Character(imageName: imageName ?? "", sound: sound)
        if let spriteComponent = character?.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: story?.characterXPosition ?? 0.0, y: story?.characterYPosition ?? 0.0)
            spriteComponent.node.zPosition = 10
        }
        entityManager.add(character!)
    }
    
    func makeCharacterTutorial(imageName: String?, sound: Effect?) {
        entityManager = EntityManager(scene: self)
        
        character = Character(imageName: imageName ?? "", sound: sound)
        if let spriteComponent = character?.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: story?.characterXPosition ?? 0.0, y: story?.characterYPosition ?? 0.0)
            spriteComponent.node.zPosition = 10
            spriteComponent.node.setScale(1.05)
        }
        
        entityManager.add(character!)
    }
    
    func makeCharacterGame(imageName: String?, sound: Effect?) {
        entityManager = EntityManager(scene: self)
        
        character = Character(imageName: imageName ?? "", sound: sound)
        if let spriteComponent = character?.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: animatedGame?.characterXPosition ?? 0.0, y: animatedGame?.characterYPosition ?? 0.0)
            spriteComponent.node.zPosition = 0
            spriteComponent.node.setScale(1.05)
        }
        
        entityManager.add(character!)
    }
    
}
