//
//  Data.swift
//  Storybook
//
//  Created by zy on 24/10/22.
//

import Foundation

enum AttributeLevel: String {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

let themes: [ThemeModel] = ThemeModel().feedingThemes()
let stories: [StoryModel] = StoryModel().feedingZooStories()
let shapes: [ShapeModel] = ShapeModel().feedingZooShapes()
let shapeTargets: [ShapeTargetModel] = ShapeTargetModel().feedingShapeTargets()
let shapeAnimations: [ShapeAnimationModel] = ShapeAnimationModel().feedingShapeAnimations()
let characters: [CharacterModel] = CharacterModel().feedingCharacters()
