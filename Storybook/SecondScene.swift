//
//  SecondScene.swift
//  Storybook
//
//  Created by zy on 29/09/22.
//

import SpriteKit
import GameplayKit

class SecondScene: SKScene, ButtonDelegate {
    private var introButton = Button()
    
    var backgroundSound = SKAudioNode(fileNamed: "bg-audio.mp3")
    
    override func sceneDidLoad() {
        addChild(self.backgroundSound)
        self.backgroundSound.run(SKAction.changeVolume(to: 0.2, duration: 0))
        if let introButton = self.childNode(withName: "introButton") as? Button {
            self.introButton = introButton
            introButton.delegate = self
        }
    }
    
    
    func buttonClicked(sender: Button) {
        if sender == introButton {
            self.introButton.run(SKAction.fadeOut(withDuration: 0.5)){
                self.backgroundSound.run(SKAction.stop())
            }
        }
    }
}
