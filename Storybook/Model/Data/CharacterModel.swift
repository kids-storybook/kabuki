//
//  CharacterModel.swift
//  Storybook
//
//  Created by zy on 18/11/22.
//

import Foundation

struct CharacterModel {
    var challengeName: String?
    var characterAtlas: String?
    var characterXPosition: Double?
    var characterYPosition: Double?

    func feedingCharacters() -> [CharacterModel] {
        let characters = [
            CharacterModel(challengeName: "lion_challenge", characterAtlas: "LionMinigameAnimation",
                           characterXPosition: -350, characterYPosition: 30),
            CharacterModel(challengeName: "elephant_challenge", characterAtlas: "ElephantShapesAnimation",
                           characterXPosition: 500, characterYPosition: 55),
            CharacterModel(challengeName: "panda_challenge", characterAtlas: "PandaMinigameAnimation",
                           characterXPosition: -300, characterYPosition: 75)
        ]
        return characters
    }
}
