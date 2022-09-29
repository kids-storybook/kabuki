//
//  GameScene.swift
//  Storybook
//
//  Created by zy on 27/09/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, ButtonDelegate {
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
        
        addChild(jillBill)
    }
    
    override func sceneDidLoad() {
        addChild(self.backgroundSound)
        self.backgroundSound.run(SKAction.changeVolume(to: 0.2, duration: 0))
    }
    
    override func didMove(to view: SKView) {
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
        let idleAnimation = SKAction.animate(with: jillBillIdleTextures, timePerFrame: 0.3)
        jillBill.run(SKAction.repeatForever(idleAnimation), withKey: "jillBillIdleAnimation")
    }
    
    func jillBillMoveEnded() {
        jillBill.removeAllActions()
        backgroundSound.run(SKAction.sequence([SKAction.changeVolume(to: 0, duration: 0.3), SKAction.stop()]))
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
            // if legs are not moving, start them
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
    
    //    var entities = [GKEntity]()
    //    var graphs = [String : GKGraph]()
    //
    //    private var lastUpdateTime : TimeInterval = 0
    //
    //    override func sceneDidLoad() {
    //
    //        self.lastUpdateTime = 0
    //
    //        // Get label node from scene and store it for use later
    //        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
    //        if let label = self.label {
    //            label.alpha = 0.0
    //            label.run(SKAction.fadeIn(withDuration: 2.0))
    //        }
    //
    //        // Create shape node to use during mouse interaction
    //        let w = (self.size.width + self.size.height) * 0.05
    //        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
    //
    //        if let spinnyNode = self.spinnyNode {
    //            spinnyNode.lineWidth = 2.5
    //
    //            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
    //            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
    //                                              SKAction.fadeOut(withDuration: 0.5),
    //                                              SKAction.removeFromParent()]))
    //        }
    //    }
    //
    //
    //    override func update(_ currentTime: TimeInterval) {
    //        // Called before each frame is rendered
    //
    //        // Initialize _lastUpdateTime if it has not already been
    //        if (self.lastUpdateTime == 0) {
    //            self.lastUpdateTime = currentTime
    //        }
    //
    //        // Calculate time since last update
    //        let dt = currentTime - self.lastUpdateTime
    //
    //        // Update entities
    //        for entity in self.entities {
    //            entity.update(deltaTime: dt)
    //        }
    //
    //        self.lastUpdateTime = currentTime
    //    }
}
