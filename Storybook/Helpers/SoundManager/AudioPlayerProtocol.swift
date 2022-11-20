//
//  AudioPlayerProtocol.swift
//  Storybook
//
//  Created by zy on 20/11/22.
//

import Foundation

protocol AudioPlayer {
    
    var musicVolume: Float { get set }
    func play(music: Music)
    func pause(music: Music)
    
    var effectsVolume: Float { get set }
    func play(effect: Effect)
}
