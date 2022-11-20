//
//  AudioFiles.swift
//  Storybook
//
//  Created by zy on 20/11/22.
//

import Foundation

struct Audio {
    
    struct MusicFiles {
        static let map = [
            "zoo" : Music(filename: "Maps Music-zoo", type: "mp3")
        ]
        static let shapeGame = [
            "lion_challenge" : Music(filename: "Mini Games-lion_challenge", type: "mp3"),
            "elephant_challenge" : Music(filename: "Mini Games-elephant_challenge", type: "mp3"),
            "panda_challenge" : Music(filename: "Mini Games-panda_challenge", type: "mp3"),
        ]
        static let story = [
            "lion_challenge" : Music(filename: "Story Music-lion_challenge", type: "mp3"),
            "elephant_challenge" : Music(filename: "Story Music-elephant_challenge", type: "mp3"),
            "panda_challenge" : Music(filename: "Story Music-panda_challenge", type: "mp3"),
        ]
        static let homepage = Music(filename: "Opening Music", type: "mp3")
    }
    
    struct EffectFiles {
        static let clickedButton = Effect(filename: "button-click", type: "wav")
        static let correctAnswer = Effect(filename: "Correct-Answer", type: "wav")
        static let wrongAnswer = Effect(filename: "Wrong-Answer", type: "wav")
        static let animal = [
            "lion_challenge" : Effect(filename: "Lion-Rawr", type: "wav"),
            "elephant_challenge" : Effect(filename: "Elephant-Rawr", type: "wav"),
            "panda_challenge" : Effect(filename: "Panda-Rawr", type: "wav"),
        ]
        static let shape = [
            "Persegi" : Effect(filename: "VO-Persegi", type: "mp3"),
            "Segitiga" : Effect(filename: "VO-Segitiga", type: "mp3"),
            "Lingkaran" : Effect(filename: "VO-Lingkaran", type: "mp3"),
        ]
    }
}
