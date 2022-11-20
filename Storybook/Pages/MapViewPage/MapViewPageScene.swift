//
//  MapViewPageScene.swift
//  Storybook
//
//  Created by zy on 10/10/22.
//

import SpriteKit
import GameplayKit

class MapViewPageScene: SKScene {
    var theme: Themes?
    var backgroundScene: Background?
    var activeChallenges: [String:Challenge] = [:]
    var homeBtn: SKSpriteNode!
    
    // Entity-component system
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView) {
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add background
        backgroundScene = Background(imageName: self.theme?.mapBackground ?? "")
        if let background = backgroundScene {
            let spriteComponent = background.component(ofType: SpriteComponent.self)
            spriteComponent?.node.size = self.frame.size
            entityManager.add(background)
        }
        
        // Add background sound
        if let music = Audio.MusicFiles.map[self.theme?.name ?? ""] {
            AudioPlayerImpl.sharedInstance.play(music: music)
        }
        
        showActiveCage()
        showHomeButton()
    }
    
    func showActiveCage() {
        for challenge in theme?.challenges?.array as! [Challenges] {
            var backgroundName = challenge.background ?? ""
            if !(challenge.isActive) {
                backgroundName = backgroundName.replacingOccurrences(of: "bright", with: "dark")
            }
            let activeChallenge = Challenge(imageName: backgroundName, challengeName: challenge.challengeName ?? "")
            if let spriteComponent = activeChallenge.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: challenge.xCoordinate, y: challenge.yCoordinate)
                spriteComponent.node.zPosition = challenge.zPosition
            }
            
            activeChallenges[challenge.challengeName ?? ""] = activeChallenge
            entityManager.add(activeChallenge)
        }
    }
    
    func showHomeButton() {
        homeBtn = SKSpriteNode(imageNamed: "homeButton")
        homeBtn.position = CGPoint(x: CGRectGetMinX(self.frame) + 100, y: CGRectGetMaxY(self.frame) - 100)
        addChild(homeBtn)
    }
    
    func goToScene(scene: SKScene, transition: SKTransition) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "HomepageScene") as! HomepageScene
        return scene
    }
    
    override func willMove(from view: SKView) {
        if let background = backgroundScene {
            entityManager.remove(background)
        }
        
        for challenge in activeChallenges {
            entityManager.remove(challenge.value)
        }
        
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node == homeBtn {
                AudioPlayerImpl.sharedInstance.stop()
                homeBtn.buttonEffect(soundEffect: Audio.EffectFiles.clickedButton)
                goToScene(scene: exitScene()!, transition: SKTransition.fade(withDuration: 1.3))
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
            if let name = node.name, name.contains("_challenge") {
                let challenge = self.activeChallenges[name]
                
                let challengeNode = challenge?.component(ofType: SpriteComponent.self)
                challengeNode?.node.buttonEffect(soundEffect: Audio.EffectFiles.clickedButton)
                
                let selectedChallenge = self.theme?.challenges?.filtered(using: NSPredicate(format: "challengeName == %@", name)).array[0] as! Challenges
                
                if !selectedChallenge.isActive{
                    return
                }
                
                
                if let scene = GKScene(fileNamed: "StartPageScene") {
                    AudioPlayerImpl.sharedInstance.stop()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        // Get the SKScene from the loaded GKScene
                        if let sceneNode = scene.rootNode as! StartPageScene? {
                            // Set the scale mode to scale to fit the window
                            sceneNode.scaleMode = .aspectFill
                            sceneNode.challengeName = name
                            sceneNode.themeName = self.theme?.name ?? ""
                            // Present the scene
                            if let view = self.view {
                                view.ignoresSiblingOrder = true
                                view.showsFPS = false
                                view.showsNodeCount = false
                                view.showsDrawCount = false
                                view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1.3))
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}
