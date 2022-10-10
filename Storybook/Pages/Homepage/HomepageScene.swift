//
//  HomepageScene.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import SpriteKit
import GameplayKit


class HomepageScene: SKScene {
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()
    let backgroundSound = SKAudioNode(fileNamed: "bg-audio.mp3")
    let background = SKSpriteNode(imageNamed: "background")
    
    // Entity-component system
    var entityManager: EntityManager!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.size.width = self.size.height * (UIScreen.main.bounds.size.width / UIScreen.main.bounds.size.height)
    }
    
    override func didMove(to view: SKView) {
        print("scene size: \(size)")
        
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add background sound
        backgroundSound.run(SKAction.sequence([SKAction.changeVolume(to: 0.3, duration: 0), SKAction.fadeIn(withDuration: 3)]))
        backgroundSound.autoplayLooped = true
        addChild(backgroundSound)
        
        // Add background
        background.position = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = -1
        addChild(background)
        
        addChild(moveableNode)
        prepareHorizontalScrolling()
    }
    
    override func willMove(from view: SKView) {
        scrollView?.removeFromSuperview()
        scrollView = nil
        
        moveableNode.removeAllActions()
        moveableNode.removeFromParent()
        moveableNode.removeAllChildren()
        
        backgroundSound.removeAllActions()
        backgroundSound.removeFromParent()
        backgroundSound.removeAllChildren()
        
        background.removeFromParent()
        background.removeAllChildren()
        
        print("BYEBYE")
    }
    
    func startPressed() {
        print("Start pressed!")
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            if let name = node.name, Theme.allValues.contains(where: {
                $0.range(of: name, options: .caseInsensitive) != nil
            }) {
                print("aw, touches began!")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            if let name = node.name, Theme.allValues.contains(where: {
                $0.range(of: name, options: .caseInsensitive) != nil
            }) {
                node.run(SoundManager.sharedInstance.soundClickedButton)
                var scale = SKAction.scale(to: 0.9, duration: 0)
                node.run(scale)
                scale = SKAction.scale(to: 1.0, duration: 0.2)
                node.run(scale)
                
                if let mapData = Theme.allAssets[name] {
                    if mapData["isActive"] as? Bool ?? false {
                        if let scene = GKScene(fileNamed: "MapViewPageScene") {
                            // Get the SKScene from the loaded GKScene
                            if let sceneNode = scene.rootNode as! MapViewPageScene? {
                                // Set the scale mode to scale to fit the window
                                sceneNode.scaleMode = .aspectFill
                                sceneNode.data = mapData
                                
                                // Present the scene
                                if let view = self.view {
                                    view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1.0))
                                    view.ignoresSiblingOrder = true
                                    view.showsFPS = true
                                    view.showsNodeCount = true
                                }
                            }
                        }
                        print("Let's move to \(name)~")
                    } else {
                        print("Oops! This map isn't active yet, please stay tune ;)")
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
}
