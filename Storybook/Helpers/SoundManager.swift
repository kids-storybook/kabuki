//
//  SoundManager.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import Foundation
import SpriteKit

class SoundManager {
    
    let soundClickedButton = SKAction.playSoundFileNamed("button-click.wav", waitForCompletion: false)
    let soundAppreciation = ["lion_challenge" : SKAction.playSoundFileNamed("Lion-Rawr.wav", waitForCompletion: false), "elephant_challenge" : SKAction.playSoundFileNamed("Elephant-Rawr.wav", waitForCompletion: false)]
    
    static let sharedInstance = SoundManager()
    
}
