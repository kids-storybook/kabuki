//
//  GameScene.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    var start: SKNode!
    var header: SKNode!
    var footer: SKNode!
    var startBtn: SKSpriteNode!
    var nxtBtn: SKSpriteNode!
    var prevBtn: SKSpriteNode!
    var exitBtn: SKSpriteNode!
    var entityManager: EntityManager!
    
    // reusable variable for child
    var themeName: String?
    var theme: Themes?
    var challengeName: String?
    var idxScene: Int32 = 0
    var idxScenePreAnimate: Int32 = 0
    var idxSceneAnimate: Int32 = 0
    var addCharacter: [Stories]?
    var character: [Character] = []
    var stories: Stories?

    
    
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
    
    func goToScene(scene: SKScene, transitionDirection: SKTransitionDirection) {
        let sceneTransition = SKTransition.push(with: transitionDirection, duration: 1.5)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: sceneTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if let start = start, start.contains(touchLocation) {
            let location = touch.location(in: start)
            let node = atPoint(location)
            node.run(SoundManager.sharedInstance.soundClickedButton)
            if startBtn.contains(location) {
                goToScene(scene: getNextScene()!, transitionDirection: SKTransitionDirection.left)
            }
            
        } else if let footer = footer, footer.contains(touchLocation) {
            let location = touch.location(in: footer)
            
            if nxtBtn.contains(location) {
                nxtBtn.run(SoundManager.sharedInstance.soundClickedButton)
                goToScene(scene: getNextScene()!, transitionDirection: SKTransitionDirection.left)
            }
            else if prevBtn.contains(location) {
                prevBtn.run(SoundManager.sharedInstance.soundClickedButton)
                goToScene(scene: getPreviousScene()!, transitionDirection: SKTransitionDirection.right)
            }
            
        }
        else if header.contains(touchLocation) {
            let location = touch.location(in: header)
            
            if exitBtn.contains(location) {
                exitBtn.run(SoundManager.sharedInstance.soundClickedButton)
                goToScene(scene: exitScene()!, transitionDirection: SKTransitionDirection.right)
            }
        }
        else {
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
    
    func makeCharacter(imageName: String?) {
        
        entityManager = EntityManager(scene: self)
        
        let character = Character(imageName: imageName ?? "")
        if let spriteComponent = character.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: stories?.characterXPosition ?? 0.0, y: stories?.characterYPosition ?? 0.0)
//            spriteComponent.node.size = CGSize(width: stories?.characterWidth ?? 0.0, height: stories?.characterHeight ?? 0.0)
            spriteComponent.node.zPosition = 10
        }
        
        entityManager.add(character)
    }
    
    func makeCharacterTutorial(imageName: String?) {
        entityManager = EntityManager(scene: self)
        
        let character = Character(imageName: imageName ?? "")
        if let spriteComponent = character.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: stories?.characterXPosition ?? 0.0, y: stories?.characterYPosition ?? 0.0)
//            spriteComponent.node.size = CGSize(width: 1260, height: 516)
            spriteComponent.node.zPosition = 10
        }
        
        entityManager.add(character)
    }
    
    func setupCharacter(imageName: String?) {
        
        //Create shapes
        for (_, characters) in (addCharacter ?? []).enumerated() {
            let activeCharacter = Character(imageName: imageName ?? "")
            if let spriteComponent = activeCharacter.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: characters.characterYPosition , y: characters.characterXPosition)
//                spriteComponent.node.size = CGSize(width: characters.characterWidth, height: characters.characterHeight)
//                spriteComponent.node.setScale(0.55)
                
            }
            character.append(activeCharacter)
            entityManager.add(activeCharacter)
        }
    }
    
}
