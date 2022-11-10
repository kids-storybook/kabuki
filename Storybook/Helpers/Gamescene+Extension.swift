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
    
    func makeCharacter(imageName: String?) {
        
        entityManager = EntityManager(scene: self)
        
        let character = Character(imageName: imageName ?? "")
        if let spriteComponent = character.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: story?.characterXPosition ?? 0.0, y: story?.characterYPosition ?? 0.0)
            spriteComponent.node.zPosition = 10
        }
        print(character)
        entityManager.add(character)
    }
    
    func makeCharacterTutorial(imageName: String?) {
        entityManager = EntityManager(scene: self)
        
        let character = Character(imageName: imageName ?? "")
        if let spriteComponent = character.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: story?.characterXPosition ?? 0.0, y: story?.characterYPosition ?? 0.0)
            spriteComponent.node.zPosition = 10
        }
        
        entityManager.add(character)
    }
    
    func setupCharacter(imageName: String?) {
        //Create shapes
        for (_, characters) in (addCharacter ?? []).enumerated() {
            let activeCharacter = Character(imageName: imageName ?? "")
            if let spriteComponent = activeCharacter.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: characters.characterYPosition , y: characters.characterXPosition)
            }
            character.append(activeCharacter)
            entityManager.add(activeCharacter)
        }
    }

}
