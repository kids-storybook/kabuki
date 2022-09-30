//
//  ThirdScene.swift
//  Storybook
//
//  Created by zy on 30/09/22.
//

import SpriteKit
import GameplayKit

class ThirdScene: SKScene, ButtonDelegate {
    private var introButton = Button()
    private var currentNode: SKNode?
    
    var jillBill: SKSpriteNode!
    var backgroundSound = SKAudioNode(fileNamed: "bg-audio.mp3")
    var box: SKSpriteNode?
    var initBoxLocation: CGPoint?
    var draghere: SKSpriteNode?

    
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
        jillBill = SKSpriteNode(texture: jillBillTexture, size: CGSize(width: 70*5, height: 46*5))
        jillBill.position = CGPoint(x: frame.minX+120, y: frame.midY+80)
        jillBill.zPosition = 2.0
        
        addChild(jillBill)
    }
    
    override func sceneDidLoad() {
        addChild(self.backgroundSound)
        self.backgroundSound.run(SKAction.changeVolume(to: 0.2, duration: 0))
        if let introButton = self.childNode(withName: "introButton") as? Button {
            self.introButton = introButton
            introButton.delegate = self
        }
        self.setupPlayer()
        self.startIdleAnimation()
    }
    
    override func didMove(to view: SKView) {
        if let box = self.childNode(withName: "box") as? SKSpriteNode {
            self.box = box
        }
        if let draghere = self.childNode(withName: "draghere") as? SKSpriteNode {
            self.draghere = draghere
        }
    }
    
    
    func buttonClicked(sender: Button) {
        if sender == introButton {
            self.introButton.run(SKAction.fadeOut(withDuration: 0.5)){
                self.backgroundSound.run(SKAction.stop())
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
        
        // Load 'FourthScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "FourthScene") {

            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! FourthScene? {
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
        let location = CGPoint(x: frame.maxX-120, y: frame.midY+80)
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
        let doneAction = SKAction.run({ [weak self] in
            self?.jillBillMoveEnded()
        })
        
        let moveActionWithDone = SKAction.sequence([SKAction.wait(forDuration: 1), moveAction, doneAction])
        jillBill.run(moveActionWithDone, withKey:"jillBillMoving")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node == self.box {
                    self.currentNode = node
                    self.initBoxLocation = location
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
        self.moveJillBill()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
}

