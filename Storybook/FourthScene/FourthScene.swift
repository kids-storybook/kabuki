//
//  FourthScene.swift
//  Storybook
//
//  Created by zy on 30/09/22.
//

import SpriteKit
import GameplayKit

class FourthScene: SKScene, ButtonDelegate {
    private var finishButton = Button()
    
    var backgroundSound = SKAudioNode(fileNamed: "bg-audio.mp3")
    
    var jillBill: SKSpriteNode!
    
    private var jillBillAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "JillBillClap")
    }
    
    private var jillBillTexture: SKTexture {
        return jillBillAtlas.textureNamed("jillBillClap")
    }
    
    private var jillBillIdleTextures: [SKTexture] {
        return [
            jillBillAtlas.textureNamed("clap1"),
            jillBillAtlas.textureNamed("clap2"),
            jillBillAtlas.textureNamed("clap3")
        ]
    }
    
    private func setupPlayer() {
        jillBill = SKSpriteNode(texture: jillBillTexture, size: CGSize(width: 70*8, height: 46*8))
        jillBill.position = CGPoint(x: frame.midX+200, y: frame.midY-200)
        jillBill.zPosition = 2.0
        
        addChild(jillBill)
    }
    
    func startIdleAnimation() {
        let idleAnimation = SKAction.animate(with: jillBillIdleTextures, timePerFrame: 0.2)
        jillBill.run(SKAction.repeatForever(idleAnimation), withKey: "jillBillIdleAnimation")
    }
    
    
    override func didMove(to view: SKView) {
        addChild(self.backgroundSound)
        self.backgroundSound.run(SKAction.changeVolume(to: 0.2, duration: 0))
        if let finishButton = self.childNode(withName: "back-button") as? Button {
            self.finishButton = finishButton
            finishButton.delegate = self
        }
        self.setupPlayer()
        self.startIdleAnimation()
    }
    
    
    func buttonClicked(sender: Button) {
        if sender == finishButton {
            self.finishButton.run(SKAction.fadeOut(withDuration: 0.5)){
                self.backgroundSound.run(SKAction.stop())
                // Load 'FirstScene.sks' as a GKScene. This provides gameplay related content
                // including entities and graphs.
                if let scene = GKScene(fileNamed: "FirstScene") {
                    
                    // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! FirstScene? {
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

