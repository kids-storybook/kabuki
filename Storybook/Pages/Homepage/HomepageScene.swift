//
//  HomepageScene.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import SpriteKit
import GameplayKit


class HomepageScene: SKScene {
    enum Config {
        static let scrollViewWidthAdjuster: CGFloat = 3
    }
    
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()
    
    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0
    
    // Entity-component system
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView) {
        print("scene size: \(size)")
        
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add background
        let background = SKSpriteNode(imageNamed: "background")
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
                let scale = SKAction.scale(to: 0.9, duration: 0)
                node.run(scale)
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
                let scale = SKAction.scale(to: 1.0, duration: 0.2)
                node.run(scale)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
}