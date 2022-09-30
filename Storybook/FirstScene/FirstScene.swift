//
//  FirstScene.swift
//  Storybook
//
//  Created by zy on 27/09/22.
//

import SpriteKit
import GameplayKit

class FirstScene: SKScene, ButtonDelegate {
    private var startButton = Button()
    
    var jillBill: SKSpriteNode!
    var backgroundSound = SKAudioNode(fileNamed: "bg-audio.mp3")
    
    private var jillBillAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "JillBill")
    }
    
    private var jillBillTexture: SKTexture {
        return jillBillAtlas.textureNamed("jillBill")
    }
    
    private var jillBillIdleTextures: [SKTexture] {
        return [
            jillBillAtlas.textureNamed("idle1"),
            jillBillAtlas.textureNamed("idle2"),
            jillBillAtlas.textureNamed("idle3"),
            jillBillAtlas.textureNamed("idle4")
        ]
    }
    
    private func setupPlayer() {
        jillBill = SKSpriteNode(texture: jillBillTexture)
        jillBill.position = CGPoint(x: frame.midX, y: -frame.height/4+100)
        jillBill.zPosition = 2.0
        
        addChild(jillBill)
    }
    
    override func sceneDidLoad() {
        addChild(self.backgroundSound)
        self.backgroundSound.run(SKAction.changeVolume(to: 0.2, duration: 0))
        if let startButton = self.childNode(withName: "startButton") as? Button {
            self.startButton = startButton
            startButton.delegate = self
        }
    }
    
    func buttonClicked(sender: Button) {
        if sender == startButton {
            startButton.run(SKAction.fadeOut(withDuration: 0.5)){
                self.setupPlayer()
                self.startIdleAnimation()
                self.moveJillBill()
            }
        }
    }
    
    func startIdleAnimation() {
        let idleAnimation = SKAction.animate(with: jillBillIdleTextures, timePerFrame: 0.2)
        jillBill.run(SKAction.repeatForever(idleAnimation), withKey: "jillBillIdleAnimation")
    }
    
    func jillBillMoveEnded() {
        jillBill.removeAllActions()
        backgroundSound.run(SKAction.sequence([SKAction.changeVolume(to: 0, duration: 0.3), SKAction.stop()]))
        
        // Load 'SecondScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "SecondScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! SecondScene? {
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
    
    func moveJillBill() {
        let location = CGPoint(x: frame.midX, y: frame.maxY-270)
        var multiplierForDirection: CGFloat
        let jillBillSpeed = frame.size.width / 5.0
        
        let moveDifference = CGPoint(x: location.x - jillBill.position.x, y: location.y - jillBill.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        
        let moveDuration = distanceToMove / jillBillSpeed
        
        if moveDifference.x < 0 {
            multiplierForDirection = 1.0
        } else {
            multiplierForDirection = -1.0
        }
        
        jillBill.xScale = abs(jillBill.xScale) * multiplierForDirection
        
        if jillBill.action(forKey: "jillBillIdleAnimation") == nil {
            // if Jill & Bill no animated, lets start it again
            self.startIdleAnimation()
        }
        
        let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
        let scaleAction = SKAction.scale(by: 0.18, duration: (TimeInterval(moveDuration)))
        let doneAction = SKAction.run({ [weak self] in
            self?.jillBillMoveEnded()
        })
        
        let moveActionWithDone = SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.group([moveAction, scaleAction]), doneAction])
        jillBill.run(moveActionWithDone, withKey:"jillBillMoving")
    }
}
