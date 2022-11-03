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
    var shapeOrder: Int32?
    var level: String?
    
    var backgroundScene: SKSpriteNode!
    var shapeTargets: [String:Shape] = [:]
    var activeShapes: [Shape] = []
    var solvedShapes: Set<String> = Set([])
    
    func setBackground() {
        let challenge = self.theme?.challenges?.filtered(using: NSPredicate(format: "challengeName == %@", self.challengeName ?? "")).array as! [Challenges]
        
        backgroundScene = SKSpriteNode(imageNamed: challenge[0].gameBackground ?? "")
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        addChild(backgroundScene)
        
        // Add background sound
        let soundPayload: [String: Any] = ["fileToPlay" : "Mini Games-\(self.challengeName ?? "")", "isKeepToPlay": true ]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PlayBackgroundSound"), object: self, userInfo:soundPayload)
    }
    
    
    func setupShapes() {
        //Create shapes
        for (idx, shape) in (shapes ?? []).enumerated() {
            let activeShape = Shape(imageName: shape?.background ?? "", shapeName: shape?.background?.components(separatedBy: "_")[0] ?? "")
            if let spriteComponent = activeShape.component(ofType: SpriteComponent.self) {
                let line = idx + 1 < 4 ? 0 : (idx+1 / 3) - 1
                spriteComponent.node.position = CGPoint(x: frame.midX-CGFloat(idx*250), y: frame.midY - 200 + CGFloat((line*180)))
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
            let orderPredicate = NSPredicate(format: "order == \(self.shapeOrder ?? 0)")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", self.challengeName ?? "")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            shapes = try context.fetch(fetchRequest)
            
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate
            ])
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.propertiesToGroupBy = ["order"]
            fetchRequest.propertiesToFetch = ["order"]
            fetchRequest.resultType = .dictionaryResultType
            totalGames = try context.fetch(fetchRequest).count
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
                    node.run(SoundManager.sharedInstance.soundClickedButton)
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
            switch name{
            case "triangle":
                if triangleBin.node.frame.contains(node.position){
                    node.position = triangleBin.node.position
                    node.run(SoundManager.sharedInstance.soundClickedButton)
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
            case "square":
                if squareBin.node.frame.contains(node.position){
                    node.position = squareBin.node.position
                    node.run(SoundManager.sharedInstance.soundClickedButton)
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
            case "circle":
                if circleBin.node.frame.contains(node.position){
                    node.position = circleBin.node.position
                    node.run(SoundManager.sharedInstance.soundClickedButton)
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
            default:
                break
            }
            
            switch level{
            case AttributeLevel.easy.rawValue:
                break
            case AttributeLevel.medium.rawValue:
                node.run(SKAction.fadeOut(withDuration: 1))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let entity = self.activeShapes.filter({$0.component(ofType: SpriteComponent.self)?.node.name == name})[0]
                    self.entityManager.remove(entity)
                }
            case AttributeLevel.hard.rawValue:
                print("hard nih")
            default:
                print("not detected")
                break
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.solvedShapes.count == self.shapes?.count {
                for shape in self.activeShapes {
                    self.entityManager.remove(shape)
                }
                self.solvedShapes.removeAll()
                
                if Int(self.shapeOrder ?? 0) + 1 < self.totalGames ?? 0 {
                    let scene = SKScene(fileNamed: "ShapeGameScene") as! ShapeGameScene
                    scene.challengeName = self.challengeName
                    scene.theme = self.theme
                    scene.shapeOrder = (self.shapeOrder ?? 0) + 1
                    scene.totalGames = self.totalGames
                    scene.level = self.level
                    self.goToScene(scene: scene, transition: SKTransition.fade(withDuration: 1.3))
                } else {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self, userInfo:nil)
                    let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
                    scene.theme = self.theme
                    self.goToScene(scene: scene, transition: SKTransition.fade(withDuration: 1.3))
                }
            }
            self.currentNode = nil
        }
    }
    
    override func exitScene() -> SKScene? {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self, userInfo:nil)
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
}
