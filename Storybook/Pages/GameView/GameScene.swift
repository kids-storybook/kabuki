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
    
    func makeLion(imageName: String?) {
        
        entityManager = EntityManager(scene: self)
        
        let lionCub = Lion(imageName: imageName ?? "")
//        print(lionCub)
        if let spriteComponent = lionCub.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.frame.midX/2+25, y: spriteComponent.node.frame.midY/2-85)
            spriteComponent.node.size = CGSize(width: 550, height: 550)
            spriteComponent.node.zPosition = 10
        }
        
        let lionMom = Lion(imageName: "#1 Female Lion")
        if let spriteComponent = lionMom.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.frame.midX/2+180, y: -spriteComponent.node.frame.midY/2-45)
            spriteComponent.node.size = CGSize(width: 550, height: 550)
            spriteComponent.node.zPosition = 5
        }
        
        let lionDad = Lion(imageName: "#1 Lion")
        if let spriteComponent = lionDad.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: -spriteComponent.node.frame.midX/2-195, y: -spriteComponent.node.frame.midY/2-35)
            spriteComponent.node.size = CGSize(width: 600, height: 600)
            spriteComponent.node.zPosition = 5
        }
        
        entityManager.add(lionCub)
//        entityManager.add(lionMom)
//        entityManager.add(lionDad)
    }
    
    func makeLionTutorial() {
        entityManager = EntityManager(scene: self)
        
        let lionCub = Lion(imageName: "#1 Anak Singa")
        if let spriteComponent = lionCub.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: -spriteComponent.node.frame.midX/2-250, y: spriteComponent.node.frame.midY/2-85)
            spriteComponent.node.size = CGSize(width: 550, height: 550)
            spriteComponent.node.zPosition = 10
        }
        
        let lionMom = Lion(imageName: "#1 Female Lion")
        if let spriteComponent = lionMom.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.frame.midX/2+300, y: -spriteComponent.node.frame.midY/2-45)
            spriteComponent.node.size = CGSize(width: 550, height: 550)
            spriteComponent.node.zPosition = 5
        }
        
        let lionDad = Lion(imageName: "#1 Lion")
        if let spriteComponent = lionDad.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: -spriteComponent.node.frame.midX/2-475, y: -spriteComponent.node.frame.midY/2-35)
            spriteComponent.node.size = CGSize(width: 600, height: 600)
            spriteComponent.node.zPosition = 5
        }
        
        entityManager.add(lionCub)
        entityManager.add(lionMom)
        entityManager.add(lionDad)
    }
    
}
