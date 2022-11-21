//
//  ShapeGameScene.swift
//  Storybook
//
//  Created by Leonard Fernando on 20/10/22.
//

import SpriteKit
import Foundation
import Mixpanel

class ShapeGameScene: GameScene {
    private var currentNode: SKNode?
    var shapes: [Shapes?]?
    var totalGames: Int?
    var shapeOrder: Int32?
    var level: String?
    var nextChallenge: String?

    var backgroundScene: Background?
    var targets: [String: [SpriteComponent]] = [:]
    var activeShapes: [Shape] = []
    var solvedShapes: Set<String> = Set([])

    func setBackground() {

        let challenge = self.theme?.challenges?.filtered(using: NSPredicate(
            format: "challengeName == %@", self.challengeName ?? "")
        ).array as? [Challenges]

        nextChallenge = challenge?[0].nextChallenge

        // Add background
        backgroundScene = Background(imageName: challenge?[0].gameBackground ?? "")
        if let background = backgroundScene {
            let spriteComponent = background.component(ofType: SpriteComponent.self)
            spriteComponent?.node.size = self.frame.size
            entityManager.add(background)
        }

        // Add background sound
        if !AudioPlayerImpl.sharedInstance.isMusicPlaying() {
            if let music = Audio.MusicFiles.shapeGame[self.challengeName ?? ""] {
                AudioPlayerImpl.sharedInstance.play(music: music)
            }
        }
    }

    func setupEasyShapes(spriteComponent: SpriteComponent, idxX: Int, idx: Int) {
        spriteComponent.node.position = CGPoint(
            x: frame.midX-CGFloat(idxX*250),
            y: frame.midY - 200 + CGFloat(((idx/3)*180))
        )
    }

    func setupShapes() {
        var idxY = 0
        for (idx, shape) in (shapes ?? []).enumerated() {
            let name = (shape?.background ?? "")
            let activeShape = Shape(imageName: name, shapeName: name,
                                    sound: Audio.EffectFiles.animal[shape?.challengeName ?? ""])
            if let spriteComponent = activeShape.component(ofType: SpriteComponent.self) {
                var idxX = idx
                if idxX > 3 {
                    idxX = idx - 4 - ((idx/4 - 1) * 4)
                }

                switch level {
                case AttributeLevel.EASY.rawValue:
                    setupEasyShapes(spriteComponent: spriteComponent, idxX: idxX, idx: idx)
                case AttributeLevel.MEDIUM.rawValue:
                    let mod = (shapes?.count ?? 0) % 4

                    spriteComponent.node.position = CGPoint(
                        x: frame.width / 4 - CGFloat(idxX*250),
                        y: frame.midY + 50 + CGFloat(((idx / 4)*180))
                    )
                    if mod == 1 {
                        spriteComponent.node.position = CGPoint(
                            x: frame.width / 4 - CGFloat(idxX*250),
                            y: frame.midY + 50 + CGFloat(((idxY)*180))
                        )
                        if idx < 5 {
                            spriteComponent.node.position = CGPoint(
                                x: (frame.midX) + CGFloat((idx-2)*250),
                                y: frame.midY + 50 + CGFloat(((idx/5)*180))
                            )
                        }
                        idxY = 1
                        break
                    }

                    if idx >= (shapes?.count ?? 0) - mod && mod != 0 {
                        if mod == 3 {
                            spriteComponent.node.position = CGPoint(
                                x: (frame.midX) + CGFloat((idxX-1)*250),
                                y: frame.midY + 50 + CGFloat(((idx/4)*180))
                            )
                            break
                        } else if mod == 2 {
                            spriteComponent.node.position = CGPoint(
                                x: (frame.midX) + CGFloat((Double(Double(idxX)-0.5)*250)),
                                y: frame.midY + 50 + CGFloat(((idx/4)*180))
                            )
                            break
                        }
                    }

                case AttributeLevel.HARD.rawValue:
                    let mod = (shapes?.count ?? 0) % 4

                    spriteComponent.node.position = CGPoint(
                        x: (frame.midX) - CGFloat(idxX*200),
                        y: frame.minY + 100 + CGFloat(((idx / 4)*180)))
                    if shapes?.count ?? 0 > 8 && mod == 0 {
                        spriteComponent.node.position = CGPoint(
                            x: (frame.midX) - CGFloat(idxX*180),
                            y: frame.minY + 100 + CGFloat(((idx / 4)*110)))
                    }
                    if mod == 1 {
                        spriteComponent.node.position = CGPoint(
                            x: (frame.midX) - CGFloat(idxX*200),
                            y: frame.minY + 100 + CGFloat(((idxY)*180)))
                        if idx < 5 {
                            spriteComponent.node.position = CGPoint(
                                x: (frame.midX) - CGFloat((idx-2)*200),
                                y: frame.minY + 100 + CGFloat(((idx/5)*180)))
                        }
                        idxY = 1
                        break
                    }

                    if idx >= (shapes?.count ?? 0) - mod && mod != 0 {
                        if mod == 3 {
                            spriteComponent.node.position = CGPoint(
                                x: (frame.midX) - CGFloat(idxX*250),
                                y: frame.minY + 100 + CGFloat(((idx/4)*200)))
                            break
                        } else if mod == 2 {
                            spriteComponent.node.position = CGPoint(
                                x: (frame.midX) + CGFloat((Double(Double(idxX)-0.5)*200)),
                                y: frame.minY + 100 + CGFloat(((idx/4)*200)))
                            break
                        }
                    }
                default:
                    break
                }

                spriteComponent.node.zPosition = 10
            }
            activeShapes.append(activeShape)
            entityManager.add(activeShape)
        }
    }

    func setupTargets() {
        var order: Int32 = 0
        if level == AttributeLevel.HARD.rawValue {
            order = self.shapeOrder ?? 0
        }

        for target in shapeTargets.filter({$0.order == order}) {
            if target.challengeName == self.challengeName {
                let name = (target.background ?? "")
                let shapeTarget = Shape(imageName: target.background ?? "", shapeName: name, sound: nil)
                if let spriteComponent = shapeTarget.component(ofType: SpriteComponent.self) {
                    spriteComponent.node.position = CGPoint(
                        x: target.xCoordinate ?? 0,
                        y: target.yCoordinate ?? 0)
                    switch level {
                    case AttributeLevel.EASY.rawValue:
                        spriteComponent.node.setScale(0.58)
                    case AttributeLevel.MEDIUM.rawValue:
                        spriteComponent.node.setScale(0.58)
                    default:
                        spriteComponent.node.setScale(1)
                    }

                    spriteComponent.node.zPosition = target.zPosition ?? 0
                    let arrOfShapes = targets[name.components(separatedBy: "_")[1]]

                    if arrOfShapes?.count ?? 0 > 0 {
                        targets[name.components(separatedBy: "_")[1]]?.append(spriteComponent)
                    } else {
                        targets[name.components(separatedBy: "_")[1]] = [spriteComponent]
                    }
                }
                entityManager.add(shapeTarget)
            }
            continue
        }
    }

    func wrongClick() {
        let wrongPopUp = SKLabelNode(fontNamed: "Poppins-Black")
        wrongPopUp.text = "Ayo coba lagi!"
        wrongPopUp.fontSize = 50
        wrongPopUp.fontColor = SKColor.white
        wrongPopUp.position = CGPoint(
            x: frame.midX,
            y: frame.height/4)
        wrongPopUp.addStroke(color: UIColor.red, width: 5.0)
        wrongPopUp.zPosition = 20

        addChild(wrongPopUp)

        AudioPlayerImpl.sharedInstance.play(effect: Audio.EffectFiles.wrongAnswer)
        wrongPopUp.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 2.0),
                SKAction.removeFromParent()
            ])
        )
    }

    func handleShapeBehavior(node: SKNode, name: String) {
        switch level {
        case AttributeLevel.EASY.rawValue:
            break
        case AttributeLevel.MEDIUM.rawValue:
            node.run(SKAction.fadeOut(withDuration: 1))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let entity = self.activeShapes.filter({
                    $0.component(ofType: SpriteComponent.self)?.node.name == name
                })[0]
                self.entityManager.remove(entity)
            }
        case AttributeLevel.HARD.rawValue:
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
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }
    }

    func getCharacterAssets() {
        do {
            let fetchRequest = Characters.fetchRequest()
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", self.challengeName ?? "")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate
            ])
            fetchRequest.fetchLimit = 1
            let results = try context.fetch(fetchRequest)
            characters = results[0]
        } catch let error as NSError {
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }
    }

    func handleShapeAnswer(node: SKNode) {
        let name = (node.name ?? "")
        let arrOfTargets = targets[name.components(separatedBy: "_")[1]]
        for target in arrOfTargets ?? [] where target.node.frame.contains(node.position) {
            node.position = target.node.position
            node.zPosition = target.node.zPosition
            AudioPlayerImpl.sharedInstance.play(effect: Audio.EffectFiles.correctAnswer)
            solvedShapes.insert(node.name ?? "")
            handleShapeBehavior(node: node, name: node.name ?? "")
            return

        }

        var isAnswerWrong = false

        for shapes in targets where shapes.key != name {
            for shape in shapes.value where shape.node.frame.contains(node.position) {
                wrongClick()
                node.run(
                    SKAction.sequence([
                        SKAction.scale(by: 0.5, duration: 0.15),
                        SKAction.wait(forDuration: 0.01),
                        SKAction.scale(by: 2, duration: 0.15)
                    ])
                )
                node.position = CGPoint(
                    x: frame.midX,
                    y: frame.midY - 200)
                node.zPosition = 10
                solvedShapes.remove(node.name ?? "")
                isAnswerWrong = true
                break
            }
        }

        if !isAnswerWrong {
            node.zPosition = 10
            solvedShapes.remove(node.name ?? "")
        }
    }

    public override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        getAllShapeAssets()
        getCharacterAssets()
        makeCharacterGame(imageName: self.characters?.characterAtlas, sound: nil)
        setBackground()
        setupShapes()
        setupTargets()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)

            for node in touchedNodes.reversed() where !(node.name?.contains("target") ?? true) {
                if node.name?.contains("triangle") ?? false ||
                    node.name?.contains("square") ?? false ||
                    node.name?.contains("circle") ?? false {
                    AudioPlayerImpl.sharedInstance.play(effect: Audio.EffectFiles.clickedButton)
                    self.currentNode = node
                    self.currentNode?.zPosition = 20
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
        if let node = self.currentNode {
            self.handleShapeAnswer(node: node)
        }
        if self.solvedShapes.count == self.shapes?.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                for shape in self.activeShapes {
                    self.entityManager.remove(shape)
                }
                self.solvedShapes.removeAll()
                if Int(self.shapeOrder ?? 0) + 1 < self.totalGames ?? 0 {
                    let scene = SKScene(fileNamed: "ShapeGameScene") as? ShapeGameScene
                    scene?.challengeName = self.challengeName
                    scene?.theme = self.theme
                    scene?.shapeOrder = (self.shapeOrder ?? 0) + 1
                    scene?.totalGames = self.totalGames
                    scene?.level = self.level
                    self.goToScene(scene: scene ?? SKScene(), transition: SKTransition.fade(withDuration: 1.3))
                } else {
                    AudioPlayerImpl.sharedInstance.stop()
                    let scene = SKScene(fileNamed: "AppreciationPage") as? AppreciationPage
                    Mixpanel.mainInstance().track(
                        event: "Finished Challenge",
                        properties: ["story_name": self.challengeName ?? ""]
                    )
                    scene?.challengeName = self.challengeName
                    scene?.theme = self.theme
                    scene?.nextChallenge = self.nextChallenge
                    self.goToScene(scene: scene ?? SKScene(), transition: SKTransition.fade(withDuration: 1.3))
                }
            }
        }
        self.currentNode = nil
    }

    override func exitScene() -> SKScene? {
        AudioPlayerImpl.sharedInstance.stop()
        let scene = SKScene(fileNamed: "MapViewPageScene") as? MapViewPageScene
        scene?.theme = self.theme
        return scene
    }

    override func willMove(from view: SKView) {
        if let background = backgroundScene {
            entityManager.remove(background)
        }

        for shape in self.activeShapes {
            entityManager.remove(shape)
        }
    }
}
