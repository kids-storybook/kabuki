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
    
    override func didMove(to view: SKView) {
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
                // Load 'ThirdScene.sks' as a GKScene. This provides gameplay related content
                // including entities and graphs.
                if let scene = GKScene(fileNamed: "ThirdScene") {
                    
                    // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! ThirdScene? {
                        // Set the scale mode to scale to fit the window
                        sceneNode.scaleMode = .aspectFill
                        
                        // Present the scene
                        if let view = self.view {
                            view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1.0))
                            view.ignoresSiblingOrder = true
                            view.showsFPS = true
                            view.showsNodeCount = true
                        }
                    }
                }
            }
        }
    }
}
