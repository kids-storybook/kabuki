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
    let soundOfShape = [
        "Persegi" : SKAction.playSoundFileNamed("VO-Persegi.mp3", waitForCompletion: false),
        "Segitiga" : SKAction.playSoundFileNamed("VO-Segitiga.mp3", waitForCompletion: false),
        "Lingkaran": SKAction.playSoundFileNamed("VO-Lingkaran.mp3", waitForCompletion: false)
    ]
    let soundOfAnimal = [
        "lion_challenge" : SKAction.playSoundFileNamed("Lion-Rawr.wav", waitForCompletion: false),
        "elephant_challenge" : SKAction.playSoundFileNamed("Elephant-Rawr.wav", waitForCompletion: false),
        "panda_challenge": SKAction.playSoundFileNamed("Elephant-Rawr.wav", waitForCompletion: false)
    ]
    let soundCorrectAnswer = SKAction.playSoundFileNamed("Correct-Answer.wav", waitForCompletion: false)
    let soundWrongAnswer = SKAction.playSoundFileNamed("Wrong-Answer.wav", waitForCompletion: false)
    
    static let sharedInstance = SoundManager()
    
}
