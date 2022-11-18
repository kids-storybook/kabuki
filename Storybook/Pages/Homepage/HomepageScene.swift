//
//  HomepageScene.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import SpriteKit
import GameplayKit
import Mixpanel


class HomepageScene: SKScene {
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()
    let backgroundSound = SKAudioNode(fileNamed: "Opening Music.mp3")
    let background = SKSpriteNode(imageNamed: "background")
    var themes: [Themes?] = []
    
    // Entity-component system
    var entityManager: EntityManager!
    
    // initialize core data context
    let context = Helper().getBackgroundContext()
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.size.width = self.size.height * (UIScreen.main.bounds.size.width / UIScreen.main.bounds.size.height)
        
        do {
            let fetchRequest = Themes.fetchRequest()
            themes = try context.fetch(fetchRequest)
        } catch let error as NSError {
            DispatchQueue.main.async {
                let ac = UIAlertController(title: error.localizedDescription, message: "Oops, there is error while fetching data.", preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "exit", style: .cancel){(action) in exit(0)})
                
                self.view?.window?.rootViewController!.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    override func didMove(to view: SKView) {
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add background sound
        backgroundSound.run(SKAction.fadeIn(withDuration: 3))
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
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            if let name = node.name, let theme = themes.filter({$0?.name == name})[0] {
                node.run(SoundManager.sharedInstance.soundClickedButton)
                node.run(SKAction.sequence(
                    [SKAction.scale(to: 0.9, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                
                if theme.isActive {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        if let scene = GKScene(fileNamed: "MapViewPageScene") {
                            // Get the SKScene from the loaded GKScene
                            if let sceneNode = scene.rootNode as! MapViewPageScene? {
                                // Set the scale mode to scale to fit the window
                                sceneNode.scaleMode = .aspectFit
                                sceneNode.theme = theme
                                
                                // Present the scene
                                if let view = self.view {
                                    view.presentScene(sceneNode, transition: SKTransition.fade(withDuration: 1.3))
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
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
}
