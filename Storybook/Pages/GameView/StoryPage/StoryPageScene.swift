import Foundation
import SpriteKit
import GameplayKit

class StoryPageScene: GameScene {

    var totalStories: Int?
    var backgroundScene: Background?
    var activeLabels: [SKLabelNode]?

    private func setupPlayer() {
        makeCharacter(imageName: self.story?.characterAtlas, sound: Audio.EffectFiles.animal[self.challengeName ?? ""])
        entityManager = EntityManager(scene: self)

        // Add background
        backgroundScene = Background(imageName: self.story?.background ?? "")
        if let background = backgroundScene {
            let spriteComponent = background.component(ofType: SpriteComponent.self)
            spriteComponent?.node.size = self.frame.size
            entityManager.add(background)
        }

        let rawLabels = story?.labels as? [String]

        if let labels = rawLabels {
            for (idx, label) in labels.enumerated() {
                let textScene = SKLabelNode(fontNamed: "Poppins-Black")
                textScene.text = label
                textScene.fontSize = 50
                textScene.fontColor = SKColor.white
                textScene.position = CGPoint(x: 0, y: Int(Double(frame.height)/3.5)-idx*60)
                textScene.zPosition = 100
                textScene.addStroke(color: UIColor(named: story?.labelColor ?? "") ?? textBorder, width: 7.0)
                addChild(textScene)
                activeLabels?.append(textScene)
            }
        }

    }

    override func didMove(to view: SKView) {
        do {
            let fetchRequest = Stories.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == \(idxScene)")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", challengeName ?? "")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            fetchRequest.fetchLimit = 1
            story = try context.fetch(fetchRequest)[0]
            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", challengeName ?? "")
            totalStories = try context.count(for: fetchRequest)
        } catch let error as NSError {
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }

        self.setupPlayer()
    }

    override func getNextScene() -> SKScene? {
        if Int(idxScene) < totalStories ?? 0 {
            let scene = SKScene(fileNamed: "StoryPageScene") as? StoryPageScene
            scene?.idxScene = self.idxScene + 1
            scene?.challengeName = self.challengeName
            scene?.theme = self.theme
            return scene
        }

        let scene = SKScene(fileNamed: "AnimationPageScene") as? AnimationPageScene
        scene?.challengeName = self.challengeName
        scene?.theme = self.theme
        scene?.idxScene = self.idxScene
        return scene
    }

    override func getPreviousScene() -> SKScene? {
        if idxScene > 0 {
            let scene = SKScene(fileNamed: "StoryPageScene") as? StoryPageScene
            scene?.idxScene = self.idxScene - 1
            scene?.challengeName = self.challengeName
            scene?.theme = self.theme
            return scene
        }

        let scene = SKScene(fileNamed: "StartPageScene") as? StartPageScene
        scene?.challengeName = self.challengeName
        scene?.theme = self.theme
        return scene
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

        for label in (self.activeLabels ?? []) as [SKLabelNode] {
            label.removeFromParent()
            label.removeAllChildren()
        }
    }
}
