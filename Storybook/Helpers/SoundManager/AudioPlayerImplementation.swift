//
//  AudioPlayerImplementation.swift
//  Storybook
//
//  Created by zy on 20/11/22.
//

import Foundation
import AVKit

class AudioPlayerImpl {
    
    private var currentMusicPlayer: AVAudioPlayer?
    private var currentEffectPlayer: AVAudioPlayer?
    var musicVolume: Float = 1.0 {
        didSet { currentMusicPlayer?.volume = musicVolume }
    }
    var effectsVolume: Float = 1.0
    
    static let sharedInstance = AudioPlayerImpl()
    
}

extension AudioPlayerImpl: AudioPlayer {
    
    func isMusicPlaying() -> Bool {
        return currentMusicPlayer != nil
    }
    
    func play(music: Music) {
        currentMusicPlayer?.stop()
        guard let newPlayer = try? AVAudioPlayer(soundFile: music) else { return }
        newPlayer.volume = musicVolume
        newPlayer.numberOfLoops = -1
        newPlayer.play()
        currentMusicPlayer = newPlayer
    }
    
    func stop() {
        if (currentMusicPlayer != nil){
            currentMusicPlayer?.stop()
            currentMusicPlayer = nil
        }
    }
    
    func pause(music: Music) {
        currentMusicPlayer?.pause()
    }
    
    func play(effect: Effect) {
        guard let effectPlayer = try? AVAudioPlayer(soundFile: effect) else { return }
        effectPlayer.volume = effectsVolume
        effectPlayer.play()
        currentEffectPlayer = effectPlayer
    }
}
