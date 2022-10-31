//
//  ShapeGameScene.swift
//  Storybook
//
//  Created by Leonard Fernando on 20/10/22.
//

import SpriteKit
import Foundation


class ShapeGameScene: GameScene {
    private var currentNode: SKNode?
    var shapes: [Shapes?]?
    var totalGames: Int?
    var shapeOrder: Int32 = 0
    
    var backgroundScene: SKSpriteNode!
    //    let lionCub = SKSpriteNode(imageNamed: "#1 Anak Singa")
    var shapeTargets: [String:Shape] = [:]
    var activeShapes: [Shape] = []
    var solvedShapes: Set<String> = Set([])
    
    func setBackground() {
        backgroundScene = SKSpriteNode(imageNamed: self.theme?.gameBackground ?? "")
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        addChild(backgroundScene)
        
        //        lionCub.position = CGPoint(x: frame.midX, y: frame.midY - 75)
        //        lionCub.setScale(0.15)
        //        lionCub.zPosition = -9
        //        addChild(lionCub)
    }
    
    
    func setupShapes() {
        //Create shapes
        for (idx, shape) in (shapes ?? []).enumerated() {
            let activeShape = Shape(imageName: shape?.background ?? "", shapeName: shape?.background?.components(separatedBy: "_")[0] ?? "")
            if let spriteComponent = activeShape.component(ofType: SpriteComponent.self) {
                let line = idx + 1 < 4 ? 0 : (idx+1 / 3) - 1
                spriteComponent.node.position = CGPoint(x: frame.midX-CGFloat(idx*250), y: frame.midY - 200 + CGFloat((line*180)))
                spriteComponent.node.setScale(0.62)
                spriteComponent.node.zPosition = 2
            }
            activeShapes.append(activeShape)
            entityManager.add(activeShape)
        }
    }
    
    
    func setupTargets(){
        for target in initShapeTargetData {
            if target.challengeName == self.challengeName {
                let shapeTarget = Shape(imageName: target.background ?? "", shapeName: "\(target.background ?? "")_target" )
                if let spriteComponent = shapeTarget.component(ofType: SpriteComponent.self) {
                    spriteComponent.node.position = CGPoint(x: target.xCoordinate ?? 0, y: target.yCoordinate ?? 0)
                    spriteComponent.node.setScale(0.582)
                    spriteComponent.node.alpha = 0
                    spriteComponent.node.zPosition = target.zPosition ?? 0
                }
                entityManager.add(shapeTarget)
                shapeTargets[target.background ?? ""] = shapeTarget
            }
            continue
        }
    }
    
    func wrongClick(){
        let wrongPopUp = SKLabelNode(fontNamed: "Chalkduster")
        wrongPopUp.text = "Oops, ayo geser ke tujuan yang benar!"
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
    
    func getAllShapeAssets() {
        do {
            let fetchRequest = Shapes.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == \(self.shapeOrder)")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", self.challengeName ?? "")
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
    }
    
    public override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        print("scene size: \(size)")
        
        
        getAllShapeAssets()
        setBackground()
        setupShapes()
        setupTargets()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
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
        if let node = self.currentNode,
           let triangleBin = shapeTargets["triangle"]?.component(ofType: SpriteComponent.self),
           let squareBin = shapeTargets["square"]?.component(ofType: SpriteComponent.self),
           let circleBin = shapeTargets["circle"]?.component(ofType: SpriteComponent.self),
           let name = node.name {
            if name == "triangle"{
                if triangleBin.node.frame.contains(node.position){
                    node.position = triangleBin.node.position
                    solvedShapes.insert(name)
                }
                else if squareBin.node.frame.contains(node.position) || circleBin.node.frame.contains(node.position){
                    wrongClick()
                    node.run(
                        SKAction.sequence([
                            SKAction.scale(by: 0.5, duration: 0.15),
                            SKAction.wait(forDuration: 0.01),
                            SKAction.scale(by: 2, duration: 0.15)
                        ])
                    )
                    node.position = CGPoint(x: frame.midX, y: frame.midY - 200)
                    solvedShapes.remove(name)
                } else {
                    solvedShapes.remove(name)
                }
            }
            else if name == "square"{
                if squareBin.node.frame.contains(node.position){
                    node.position = squareBin.node.position
                    solvedShapes.insert(name)
                }
                else if triangleBin.node.frame.contains(node.position) || circleBin.node.frame.contains(node.position){
                    node.run(
                        SKAction.sequence([
                            SKAction.scale(by: 0.5, duration: 0.15),
                            SKAction.wait(forDuration: 0.02),
                            SKAction.scale(by: 2, duration: 0.15)
                        ])
                    )
                    wrongClick()
                    node.position = CGPoint(x: frame.midX-500, y: frame.midY - 200)
                    solvedShapes.remove(name)
                }
                else {
                    solvedShapes.remove(name)
                }
            }
            else if name == "circle"{
                if circleBin.node.frame.contains(node.position){
                    node.position = circleBin.node.position
                    solvedShapes.insert(name)
                }
                else if triangleBin.node.frame.contains(node.position) || squareBin.node.frame.contains(node.position){
                    node.run(
                        SKAction.sequence([
                            SKAction.scale(by: 0.5, duration: 0.15),
                            SKAction.wait(forDuration: 0.02),
                            SKAction.scale(by: 2, duration: 0.15)
                        ])
                    )
                    wrongClick()
                    node.position = CGPoint(x: frame.midX-250, y: frame.midY - 200)
                    solvedShapes.remove(name)
                } else {
                    solvedShapes.remove(name)
                }
            }
        }
        if solvedShapes.count == shapes?.count {
            shapeOrder += 1
            for shape in activeShapes {
                entityManager.remove(shape)
            }
            getAllShapeAssets()
            setupShapes()
            solvedShapes.removeAll()
        }
        self.currentNode = nil
    }
    
    override func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
}
