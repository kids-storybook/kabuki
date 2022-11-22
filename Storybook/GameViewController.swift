//
//  GameViewController.swift
//  Storybook
//
//  Created by zy on 27/09/22.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFAudio

class GameViewController: UIViewController {
    var bgSoundPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        let helper = Helper()
        let context = helper.getBackgroundContext()
        helper.initializeDB(context: context)

        // Load 'HomepageScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "HomepageScene") {

            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as? HomepageScene? {
                // Set the scale mode to scale to fit the window
                sceneNode?.scaleMode = .aspectFill

                // Present the scene
                if let view = self.view as? SKView? {
                    view?.ignoresSiblingOrder = true
                    view?.showsFPS = false
                    view?.showsNodeCount = false
                    view?.showsDrawCount = false
                    view?.presentScene(sceneNode)
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }

    override var prefersStatusBarHidden: Bool {
        true
    }
}
