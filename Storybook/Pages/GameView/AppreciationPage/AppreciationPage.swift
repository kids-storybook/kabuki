import Foundation
import SpriteKit
import GameplayKit

class AppreciationPage: GameScene {
    var backgroundScene: Background?
    var titleImage: SKSpriteNode!
    var nextChallenge: String?

    private func setupPlayer() {

        makeCharacter(imageName: self.story?.characterAtlas, sound: Audio.EffectFiles.animal[self.challengeName ?? ""])

        titleImage = SKSpriteNode(imageNamed: self.story?.title ?? "")
        titleImage.position = CGPoint(x: frame.midX, y: frame.midY/2+240)
        titleImage.zPosition = 15

        // Add background
        backgroundScene = Background(imageName: self.story?.background ?? "")
        if let background = backgroundScene {
            let spriteComponent = background.component(ofType: SpriteComponent.self)
            spriteComponent?.node.size = self.frame.size
            entityManager.add(background)
        }

        AudioPlayerImpl.sharedInstance.play(
            effect: Audio.EffectFiles.animal[self.challengeName ?? ""] ?? Audio.EffectFiles.clickedButton
        )

        addChild(titleImage)

    }

    override func sceneDidLoad() {
        super.sceneDidLoad()
        continueretry = childNode(withName: "continueretry")
        retryBtn = childNode(withName: "//retryButton") as? SKSpriteNode
        continueBtn = childNode(withName: "//continueButton") as? SKSpriteNode

    }

    override func didMove(to view: SKView) {

        do {
            let fetchRequest = Stories.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == 0")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@",
                                                     (challengeName ?? "" ) + "_appreciation" )
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            fetchRequest.fetchLimit = 1
            story = try context.fetch(fetchRequest)[0]
        } catch let error as NSError {
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }

        do {
            let fetchRequest = Challenges.fetchRequest()
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (nextChallenge ?? "" ))
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate
            ])
            fetchRequest.fetchLimit = 1
            let challenge = try context.fetch(fetchRequest)[0]
            challenge.isActive = true
            try context.save()
        } catch let error as NSError {
            showAlert(withTitle: "Oops, there is error while fetching data.", message: error.localizedDescription)
        }

        self.setupPlayer()
    }

    override func getNextScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as? MapViewPageScene
        scene?.theme = self.theme
        return scene
    }

    override func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as? MapViewPageScene
        scene?.theme = self.theme
        return scene
    }

    override func getPreviousScene() -> SKScene? {
        let scene = SKScene(fileNamed: "StartPageScene") as? StartPageScene
        scene?.challengeName = self.challengeName
        scene?.theme = self.theme
        scene?.idxScene = 0
        return scene
    }

    override func willMove(from view: SKView) {
        if let background = backgroundScene {
            entityManager.remove(background)
        }

        titleImage.removeFromParent()
        titleImage.removeAllChildren()
    }
}
