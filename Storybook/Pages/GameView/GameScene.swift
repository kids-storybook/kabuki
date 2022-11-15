//
//  GameScene.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var start: SKNode!
    var header: SKNode!
    var footer: SKNode!
    var continueretry: SKNode!
    var startBtn: SKSpriteNode!
    var nxtBtn: SKSpriteNode!
    var prevBtn: SKSpriteNode!
    var exitBtn: SKSpriteNode!
    var retryBtn: SKSpriteNode!
    var continueBtn: SKSpriteNode!
    var entityManager: EntityManager!
    
    // reusable variable for child
    var themeName: String?
    var theme: Themes?
    var challengeName: String?
    var idxScene: Int32 = 0
    var idxScenePreAnimate: Int32 = 0
    var idxSceneAnimate: Int32 = 0
    var addCharacter: [Stories]?
    var character: Character?
    var story: Stories?
    var animatedGame: AnimatedGame?
    
    // initialize core data context
    let context = Helper().getBackgroundContext()
    
    // make new color for text border
    let textBorder = UIColor(red: 137, green: 165, blue: 81)
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchMoved(to: touch.location(in: self))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchUp(at: touch.location(in: self))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchUp(at: touch.location(in: self))
    }
    
    // MARK:- Stub methods - override these in sub classes
    func touchDown(at point: CGPoint) {}
    func touchMoved(to point: CGPoint) {}
    func touchUp(at point: CGPoint) {}
    func getNextScene() -> SKScene? {
        return nil
    }
    func getPreviousScene() -> SKScene? {
        return nil
    }
    
    func exitScene() -> SKScene? {
        return nil
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        header = childNode(withName: "header")
        footer = childNode(withName: "footer")
        nxtBtn = childNode(withName: "//nextButton") as? SKSpriteNode
        prevBtn = childNode(withName: "//previousButton") as? SKSpriteNode
        exitBtn = childNode(withName: "//exitButton") as? SKSpriteNode
    }
    
    func goToScene(scene: SKScene, transition: SKTransition) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let touchedNodes = self.nodes(at: touchLocation)
        
        if let start = start, start.contains(touchLocation) {
            let location = touch.location(in: start)
            if startBtn.contains(location) {
                startBtn.run(SoundManager.sharedInstance.soundClickedButton)
                startBtn.run(SKAction.sequence(
                    [SKAction.scale(to: 0.9, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                goToScene(scene: getNextScene()!, transition: SKTransition.push(with: SKTransitionDirection.left, duration: 1.3))
            }
            
        } else if let footer = footer, footer.contains(touchLocation) {
            let location = touch.location(in: footer)
            
            if nxtBtn.contains(location) {
                nxtBtn.run(SoundManager.sharedInstance.soundClickedButton)
                nxtBtn.run(SKAction.sequence(
                    [SKAction.scale(to: 0.9, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                goToScene(scene: getNextScene()!, transition: SKTransition.push(with: SKTransitionDirection.left, duration: 1.3))
            }
            else if prevBtn.contains(location) {
                prevBtn.run(SoundManager.sharedInstance.soundClickedButton)
                prevBtn.run(SKAction.sequence(
                    [SKAction.scale(to: 0.9, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                goToScene(scene: getPreviousScene()!, transition: SKTransition.push(with: SKTransitionDirection.right, duration: 1.3))
            }
            
        }
        else if header.contains(touchLocation) {
            let location = touch.location(in: header)
            
            if exitBtn.contains(location) {
                exitBtn.run(SoundManager.sharedInstance.soundClickedButton)
                exitBtn.run(SKAction.sequence(
                    [SKAction.scale(to: 0.9, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                goToScene(scene: exitScene()!, transition: SKTransition.fade(withDuration: 1.3))
            }
        }
        else if let continueretry = continueretry, continueretry.contains(touchLocation) {
            let location = touch.location(in: continueretry)
            
            if continueBtn.contains(location) {
                continueBtn.run(SoundManager.sharedInstance.soundClickedButton)
                continueBtn.run(SKAction.sequence(
                    [SKAction.scale(to: 0.9, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                goToScene(scene: getNextScene()!, transition: SKTransition.fade(withDuration: 1.3))
            }
            else if retryBtn.contains(location) {
                retryBtn.run(SoundManager.sharedInstance.soundClickedButton)
                retryBtn.run(SKAction.sequence(
                    [SKAction.scale(to: 0.9, duration: 0),
                     SKAction.scale(to: 1.0, duration: 0.1)
                    ])
                )
                goToScene(scene: getPreviousScene()!, transition: SKTransition.fade(withDuration: 1.3))
            }
            
        }
        else {
            let node = touchedNodes[0]
            switch node.name{
            case "Persegi":
                node.run(SoundManager.sharedInstance.soundOfShape["Persegi"] ?? SKAction())
            case "Segitiga":
                node.run(SoundManager.sharedInstance.soundOfShape["Segitiga"] ?? SKAction())
            case "Lingkaran":
                node.run(SoundManager.sharedInstance.soundOfShape["Lingkaran"] ?? SKAction())
            default:
                if let spriteComponent = character?.component(ofType: SpriteComponent.self), spriteComponent.node.contains(touchLocation) {
                    spriteComponent.node.run(spriteComponent.sound)
                }
            }
            touchDown(at: touchLocation)
        }
    }
    
    func initThemeData(){
        do {
            let fetchRequest = Themes.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", self.themeName ?? "")
            fetchRequest.fetchLimit = 1
            theme = try context.fetch(fetchRequest)[0]
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
    }
    
    override func didMove(to view: SKView) {
        
    }
    
}
