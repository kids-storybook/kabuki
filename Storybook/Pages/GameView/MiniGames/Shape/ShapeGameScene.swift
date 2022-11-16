//
//  ShapeGameScene.swift
//  Storybook
//
//  Created by Leonard Fernando on 20/10/22.
//

import SpriteKit
import Foundation


class ShapeGameScene: GameScene, SKPhysicsContactDelegate {
    private var currentNode: SKNode?
    var shapes: [Shapes?]?
    var totalGames: Int?
    var shapeOrder: Int32?
    var level: String?
    var nextChallenge: String?
    
    var backgroundScene: SKSpriteNode!
    var shapeTargets: [String:Shape] = [:]
    var activeShapes: [Shape] = []
    var solvedShapes: Set<String> = Set([])
    
    func setBackground() {
        
        let challenge = self.theme?.challenges?.filtered(using: NSPredicate(format: "challengeName == %@", self.challengeName ?? "")).array as! [Challenges]
        
        nextChallenge = challenge[0].nextChallenge
        
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
        var idx_y = 0
        for (idx, shape) in (shapes ?? []).enumerated() {
            let activeShape = Shape(imageName: shape?.background ?? "", shapeName: shape?.background ?? "", sound: SoundManager.sharedInstance.soundOfAnimal[shape?.challengeName ?? ""] ?? SKAction())
            if let spriteComponent = activeShape.component(ofType: SpriteComponent.self) {
                var idx_x = idx
                if idx_x > 3 {
                    idx_x = idx - 4 - ((idx/4 - 1) * 4)
                }
                
                switch level{
                case AttributeLevel.easy.rawValue:
                    spriteComponent.node.position = CGPoint(x: frame.midX-CGFloat(idx_x*250), y: frame.midY - 200 + CGFloat(((idx/3)*180)))
                case AttributeLevel.medium.rawValue:
                    let mod = (shapes?.count ?? 0) % 4
                    
                    spriteComponent.node.position = CGPoint(x: frame.width / 4 - CGFloat(idx_x*250), y: frame.midY + 50 + CGFloat(((idx / 4)*180)))
                    if mod == 1 {
                        spriteComponent.node.position = CGPoint(x: frame.width / 4 - CGFloat(idx_x*250), y: frame.midY + 50 + CGFloat(((idx_y)*180)))
                        if idx < 5 {
                            spriteComponent.node.position = CGPoint(x: (frame.midX) + CGFloat((idx-2)*250), y: frame.midY + 50 + CGFloat(((idx/5)*180)))
                        }
                        idx_y = 1
                        break
                    }
                    
                    if idx >= (shapes?.count ?? 0) - mod && mod != 0{
                        if mod == 3 {
                            spriteComponent.node.position = CGPoint(x: (frame.midX) + CGFloat((idx_x-1)*250), y: frame.midY + 50 + CGFloat(((idx/4)*180)))
                            break
                        } else if mod == 2 {
                            spriteComponent.node.position = CGPoint(x: (frame.midX) + CGFloat((Double(Double(idx_x)-0.5)*250)), y: frame.midY + 50 + CGFloat(((idx/4)*180)))
                            break
                        }
                    }
                    
                case AttributeLevel.hard.rawValue:
                    break
                default:
                    break
                }
                
                spriteComponent.node.zPosition = 15
            }
            activeShapes.append(activeShape)
            entityManager.add(activeShape)
        }
    }
    
    
    func setupTargets(){
        for target in initShapeTargetData {
            if target.challengeName == self.challengeName {
                let shapeTarget = Shape(imageName: target.background ?? "", shapeName: target.background ?? "", sound: SKAction())
                if let spriteComponent = shapeTarget.component(ofType: SpriteComponent.self) {
                    spriteComponent.node.position = CGPoint(x: target.xCoordinate ?? 0, y: target.yCoordinate ?? 0)
                    spriteComponent.node.setScale(0.58)
                    spriteComponent.node.zPosition = target.zPosition ?? 0
                }
                entityManager.add(shapeTarget)
                shapeTargets[(target.background ?? "").components(separatedBy: "_")[1]] = shapeTarget
            }
            continue
        }
    }
    
    func wrongClick(){
        let wrongPopUp = SKLabelNode(fontNamed: "Poppins-Black")
        wrongPopUp.text = "Ayo coba lagi!"
        wrongPopUp.fontSize = 50
        wrongPopUp.fontColor = SKColor.white
        wrongPopUp.position = CGPoint(x: frame.midX, y: frame.height/4)
        wrongPopUp.addStroke(color: UIColor.red, width: 5.0)
        wrongPopUp.zPosition = 20
        
        addChild(wrongPopUp)
        
        wrongPopUp.run(SoundManager.sharedInstance.soundWrongAnswer)
        wrongPopUp.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 2.0),
                SKAction.removeFromParent()
            ])
        )
    }
    
    func handleShapeBehavior(node: SKNode, name: String){
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
            break
        default:
            break
        }
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
    
    func getCharacterAssets() {
        do {
            let fetchRequest = AnimatedGame.fetchRequest()
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", self.challengeName ?? "")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate
            ])
            fetchRequest.fetchLimit = 1
            let results = try context.fetch(fetchRequest)
            animatedGame = results[0]
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
    }
    
    public override func didMove(to view: SKView) {
        print("scene size: \(size)")
        
        entityManager = EntityManager(scene: self)
        getAllShapeAssets()
        getCharacterAssets()
        
        makeCharacterGame(imageName: self.animatedGame?.characterAtlas, sound: SKAction())
        
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
                if !(node.name?.contains("target") ?? true) {
                    if node.name?.contains("triangle") ?? false || node.name?.contains("square") ?? false || node.name?.contains("circle") ?? false
                    {
                        node.run(SoundManager.sharedInstance.soundClickedButton)
                        self.currentNode = node
                    }
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
            if name.contains("triangle") {
                if triangleBin.node.frame.contains(node.position){
                    node.position = triangleBin.node.position
                    node.run(SoundManager.sharedInstance.soundCorrectAnswer)
                    solvedShapes.insert(name)
                    handleShapeBehavior(node:node, name:name)
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
            else if name.contains("square") {
                if squareBin.node.frame.contains(node.position){
                    node.position = squareBin.node.position
                    node.run(SoundManager.sharedInstance.soundCorrectAnswer)
                    solvedShapes.insert(name)
                    handleShapeBehavior(node:node, name:name)
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
            else if name.contains("circle") {
                if circleBin.node.frame.contains(node.position){
                    node.position = circleBin.node.position
                    node.run(SoundManager.sharedInstance.soundCorrectAnswer)
                    solvedShapes.insert(name)
                    handleShapeBehavior(node:node, name:name)
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
        
        
        if self.solvedShapes.count == self.shapes?.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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
                    let scene = SKScene(fileNamed: "AppreciationPage") as! AppreciationPage
                    scene.challengeName = self.challengeName
                    scene.theme = self.theme
                    scene.nextChallenge = self.nextChallenge
                    self.goToScene(scene: scene, transition: SKTransition.fade(withDuration: 1.3))
                }
            }
        }
        
        self.currentNode = nil
    }
    
    
    override func exitScene() -> SKScene? {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self, userInfo:nil)
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
    override func willMove(from view: SKView) {
        backgroundScene.removeFromParent()
        backgroundScene.removeAllChildren()
        
        for shape in self.activeShapes {
            entityManager.remove(shape)
        }
    }
}
