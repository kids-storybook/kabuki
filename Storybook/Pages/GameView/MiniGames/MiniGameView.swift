//
//  MiniGameView.swift
//  Storybook
//
//  Created by Leonard Fernando on 20/10/22.
//

import SpriteKit
import Foundation


class MiniGameView: GameScene {
    private var currentNode: SKNode?
    var shapes: [Shapes?]?
    var totalGames: Int?
    
    let backgroundScene = SKSpriteNode(imageNamed: "EasyGameScene")
    let lionCub = SKSpriteNode(imageNamed: "#1 Anak Singa")
    
    let squareBin = SKSpriteNode(imageNamed: "square")
    let triangleBin = SKSpriteNode(imageNamed: "triangle")
    let circleBin = SKSpriteNode(imageNamed: "circle")
    
    func setBackground() {
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        addChild(backgroundScene)
        
        lionCub.position = CGPoint(x: frame.midX, y: frame.midY - 75)
        lionCub.setScale(0.15)
        lionCub.zPosition = -9
        addChild(lionCub)
    }
    
    
    func setupShapes() {
        //Create shapes
        for (idx, shape) in (shapes ?? []).enumerated() {
            let activeChallenge = Shape(imageName: shape?.background ?? "", shapeName: shape?.background?.components(separatedBy: "_")[0] ?? "")
            if let spriteComponent = activeChallenge.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: frame.midX-CGFloat(idx*200), y: frame.midY - 175)
                spriteComponent.node.setScale(0.5)
                spriteComponent.node.zPosition = 2
            }
            entityManager.add(activeChallenge)
        }
    }
    
    
    func setupTargets(){
        
        //setup the yellow bin with colour, dimensions and add to scene
        triangleBin.alpha = 1
        triangleBin.setScale(0.474)
        triangleBin.position = CGPoint (x: 373.999, y: -236.251)
        triangleBin.zPosition = -1
        addChild(triangleBin)
        
        //note that we can determine property of a fixed type using shorthand, shown here for setting colour
        squareBin.alpha = 1
        squareBin.setScale(0.474)
        squareBin.position = CGPoint (x: 372.854, y: 8)
        squareBin.zPosition = -1
        addChild(squareBin)
        
        //Circle Bin
        circleBin.alpha = 1
        circleBin.setScale(0.474)
        circleBin.position = CGPoint (x: 369.188, y: 251.081)
        circleBin.zPosition = -1
        addChild(circleBin)
    }
    
    func wrongClick(){
        let wrongPopUp = SKLabelNode(fontNamed: "Chalkduster")
        wrongPopUp.text = "YAH SALAH, YUK COBA LAGE"
        wrongPopUp.fontSize = 48
        wrongPopUp.fontColor = SKColor.red
        wrongPopUp.position = CGPoint(x: frame.midX, y: frame.height/10)
        
        addChild(wrongPopUp)
        
        wrongPopUp.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.removeFromParent()
            ])
        )
    }
    
    public override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        print("scene size: \(size)")
        
        do {
            let fetchRequest = Shapes.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == \(idxScene)")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", challengeName ?? "")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            shapes = try context.fetch(fetchRequest)
            
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            totalGames = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        setBackground()
        setupShapes()
        setupTargets()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "triangle" || node.name == "square" || node.name == "circle"
                {
                    self.currentNode = node
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
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if shape is called triangle and its centre is inside the triangle target
        if let node = self.currentNode {
            if node.name == "triangle"{
                if triangleBin.frame.contains(node.position){
                    //remove it and create a new label
                    node.position = triangleBin.position
                }
                else if squareBin.frame.contains(node.position) || circleBin.frame.contains(node.position){
                    wrongClick()
                    node.run(
                        SKAction.sequence([
                            SKAction.scale(by: 0.5, duration: 0.15),
                            SKAction.wait(forDuration: 0.01),
                            SKAction.scale(by: 2, duration: 0.15)
                        ])
                    )
                    node.position = CGPoint(x: frame.midX, y: frame.midY - 175)
                }
            }
            
            //same process for square label
            else if node.name == "square"{
                if squareBin.frame.contains(node.position){
                    //remove it and create a new label
                    node.position = squareBin.position
                }
                else if triangleBin.frame.contains(node.position) || circleBin.frame.contains(node.position){
                    node.run(
                        SKAction.sequence([
                            SKAction.scale(by: 0.5, duration: 0.15),
                            SKAction.wait(forDuration: 0.02),
                            SKAction.scale(by: 2, duration: 0.15)
                        ])
                    )
                    wrongClick()
                    node.position = CGPoint(x: frame.midX-400, y: frame.midY - 175)
                }
            }
            
            //same process for circle label
            else if node.name == "circle"{
                if circleBin.frame.contains(node.position){
                    //remove it and create a new label
                    node.position = circleBin.position
                }
                else if triangleBin.frame.contains(node.position) || squareBin.frame.contains(node.position){
                    node.run(
                        SKAction.sequence([
                            SKAction.scale(by: 0.5, duration: 0.15),
                            SKAction.wait(forDuration: 0.02),
                            SKAction.scale(by: 2, duration: 0.15)
                        ])
                    )
                    wrongClick()
                    node.position = CGPoint(x: frame.midX-200, y: frame.midY - 175)
                }
            }
        }
        self.currentNode = nil
    }
    
    override func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
}
