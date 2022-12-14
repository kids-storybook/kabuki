//
//  GameScene.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit
import GameplayKit
import Mixpanel


class GameScene: SKScene, Alertable {
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
    var characters: Characters?

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

    // MARK: - Stub methods - override these in sub classes
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
                startBtn.buttonEffect(soundEffect: Audio.EffectFiles.clickedButton)
                goToScene(
                    scene: getNextScene()!,
                    transition: SKTransition.push(with: SKTransitionDirection.left, duration: 1.3)
                )
            }
        } else if let footer = footer, footer.contains(touchLocation) {
            let location = touch.location(in: footer)
            if nxtBtn.contains(location) {
                nxtBtn.buttonEffect(soundEffect: Audio.EffectFiles.clickedButton)
                Mixpanel.mainInstance().track(
                    event: "Next Button Clicked",
                    properties: ["story_name": story?.challengeName ?? ""]
                )
                goToScene(
                    scene: getNextScene()!,
                    transition: SKTransition.push(with: SKTransitionDirection.left, duration: 1.3)
                    
                )
            } else if prevBtn.contains(location) {
                prevBtn.buttonEffect(soundEffect: Audio.EffectFiles.clickedButton)
                Mixpanel.mainInstance().track(
                    event: "Prev Button Clicked",
                    properties: ["story_name": story?.challengeName ?? ""]
                )
                goToScene(
                    scene: getPreviousScene()!,
                    transition: SKTransition.push(with: SKTransitionDirection.right, duration: 1.3)
                )
            }

        } else if header.contains(touchLocation) {
            let location = touch.location(in: header)

            if exitBtn.contains(location) {
                exitBtn.buttonEffect(soundEffect: Audio.EffectFiles.clickedButton)
                Mixpanel.mainInstance().track(
                    event: "Exit Button Clicked",
                    properties: ["story_name": story?.challengeName ?? ""]
                )
                goToScene(scene: exitScene()!,
                          transition: SKTransition.fade(withDuration: 1.3)
                )
            }
        } else if let continueretry = continueretry, continueretry.contains(touchLocation) {
            let location = touch.location(in: continueretry)

            if continueBtn.contains(location) {
                continueBtn.buttonEffect(soundEffect: Audio.EffectFiles.clickedButton)
                Mixpanel.mainInstance().track(
                    event: "Continue Button Clicked",
                    properties: ["story_name": story?.challengeName ?? ""]
                )
                goToScene(
                    scene: getNextScene()!,
                    transition: SKTransition.fade(withDuration: 1.3)
                )
            } else if retryBtn.contains(location) {
                retryBtn.buttonEffect(soundEffect: Audio.EffectFiles.clickedButton)
                Mixpanel.mainInstance().track(
                    event: "Retry Button Clicked",
                    properties: ["story_name": story?.challengeName ?? ""]
                )
                goToScene(
                    scene: getPreviousScene()!,
                    transition: SKTransition.fade(withDuration: 1.3)
                )
            }

        } else {
            let node = touchedNodes[0]
            switch node.name {
            case "Persegi":
                AudioPlayerImpl.sharedInstance.play(
                    effect: Audio.EffectFiles.shape[node.name ?? ""] ?? Audio.EffectFiles.clickedButton
                )
            case "Segitiga":
                AudioPlayerImpl.sharedInstance.play(
                    effect: Audio.EffectFiles.shape[node.name ?? ""] ?? Audio.EffectFiles.clickedButton
                )
            case "Lingkaran":
                AudioPlayerImpl.sharedInstance.play(
                    effect: Audio.EffectFiles.shape[node.name ?? ""] ?? Audio.EffectFiles.clickedButton
                )
            default:
                if let spriteComponent = character?.component(ofType: SpriteComponent.self),
                   spriteComponent.node.contains(touchLocation) {
                    AudioPlayerImpl.sharedInstance.play(
                        effect: spriteComponent.sound ?? Audio.EffectFiles.clickedButton
                    )
                }
            }
            touchDown(at: touchLocation)
        }
    }

    func fetchTheme() {
        do {
            let fetchRequest = Themes.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", self.themeName ?? "")
            fetchRequest.fetchLimit = 1
            theme = try context.fetch(fetchRequest)[0]
        } catch let error as NSError {
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }
    }

    override func didMove(to view: SKView) {

    }

}
