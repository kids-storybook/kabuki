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
    
    static let sharedInstance = SoundManager()
    
}
