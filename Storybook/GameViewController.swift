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
    var bgSoundPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.playBackgroundSound(_:)), name: NSNotification.Name(rawValue: "PlayBackgroundSound"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.stopBackgroundSound(_:)), name: NSNotification.Name(rawValue: "StopBackgroundSound"), object: nil)
        
        let helper = Helper()
        let context = helper.getBackgroundContext()
        helper.initializeDB(context: context)
        
        // Load 'HomepageScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "HomepageScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! HomepageScene? {
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.showsDrawCount = true
                    view.presentScene(sceneNode)
                }
            }
        }
    }
    
    @objc func playBackgroundSound(_ notification: Notification) {
        let name = (notification as NSNotification).userInfo!["fileToPlay"] as! String
        let isKeepToPlay = (notification as NSNotification).userInfo!["isKeepToPlay"] as! Bool
        
        if (bgSoundPlayer != nil){
            if (isKeepToPlay) {
                return
            }
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
        }
        
        if (name != ""){
            let fileURL:URL = Bundle.main.url(forResource:name, withExtension: "mp3")!

            do {
                bgSoundPlayer = try AVAudioPlayer(contentsOf: fileURL)
            } catch _{
                bgSoundPlayer = nil
            }
            
            bgSoundPlayer!.numberOfLoops = -1
            bgSoundPlayer!.prepareToPlay()
            bgSoundPlayer!.play()
        }
    }
    
    @objc func stopBackgroundSound(_ notification: Notification) {
        if (bgSoundPlayer != nil){
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
        }
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        if UIDevice.current.userInterfaceIdiom == .phone {
    //            return .allButUpsideDown
    //        } else {
    //            return .all
    //        }
    //    }
    
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
