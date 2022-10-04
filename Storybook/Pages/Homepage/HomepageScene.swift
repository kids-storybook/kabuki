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
    
    private(set) lazy var clickLabel: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "HelveticaNeue")
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Tap"
        label.fontSize = 32
        label.position = CGPoint(x: 0, y: 0)
        return label
    }()
    
    // Constants
    let margin = CGFloat(30)
    
    var startButton: ButtonNode!
    
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
        
        // Add start button
//        startButton = ButtonNode(iconName: "quirk1", text: "10", onButtonPress: startPressed)
//        startButton.position = CGPoint(x: frame.midX, y: frame.height/4)
//        addChild(startButton)
        
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
//        super.touchesBegan(touches, with: event)
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            if let name = node.name, scrollView?.isDisabled == false { // or check for spriteName  ->  if node.name == "SpriteName"
                print(name)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
}
