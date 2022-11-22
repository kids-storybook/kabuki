//
//  Challenge.swift
//  Storybook
//
//  Created by zy on 18/11/22.
//

import Foundation

struct ChallengeModel {
    var background: String?
    var challengeName: String?
    var isActive: Bool?
    var xCoordinate: Double?
    var yCoordinate: Double?
    var zPosition: Double?
    var gameBackground: String?
    var level: AttributeLevel?
    var nextChallenge: String?

    func feedingZooChallenges() -> [ChallengeModel] {
        let challenges = [
            ChallengeModel(
                background: "bright_elephant_cage", challengeName: "elephant_challenge",
                isActive: false, xCoordinate: -505.187, yCoordinate: 165.877,
                zPosition: 1.0, gameBackground: "elephant_shape_background",
                level: AttributeLevel.MEDIUM, nextChallenge: "panda_challenge"),
            ChallengeModel(
                background: "bright_gorilla_cage", challengeName: "gorilla_challenge",
                isActive: false, xCoordinate: 524.09, yCoordinate: 179.16,
                zPosition: 0.0, gameBackground: "lion_shape_background",
                level: AttributeLevel.EASY, nextChallenge: "elephant_challenge"),
            ChallengeModel(
                background: "bright_giraffe_cage", challengeName: "giraffe_challenge",
                isActive: false, xCoordinate: 445.219, yCoordinate: -183.736,
                zPosition: 1.0, gameBackground: "lion_shape_background",
                level: AttributeLevel.EASY, nextChallenge: "elephant_challenge"),
            ChallengeModel(
                background: "bright_panda_cage", challengeName: "panda_challenge",
                isActive: false, xCoordinate: -217.127, yCoordinate: 390.343,
                zPosition: 1.0, gameBackground: "panda_shape_background",
                level: AttributeLevel.HARD, nextChallenge: "elephant_challenge"),
            ChallengeModel(
                background: "bright_penguin_cage", challengeName: "penguin_challenge",
                isActive: false, xCoordinate: 49.005, yCoordinate: 49.594,
                zPosition: 1.0, gameBackground: "lion_shape_background",
                level: AttributeLevel.EASY, nextChallenge: "elephant_challenge"),
            ChallengeModel(
                background: "bright_lion_cage", challengeName: "lion_challenge",
                isActive: true, xCoordinate: -440.944, yCoordinate: -255.175,
                zPosition: 2.0, gameBackground: "lion_shape_background",
                level: AttributeLevel.EASY, nextChallenge: "elephant_challenge"),
            ChallengeModel(
                background: "bright_zebra_cage", challengeName: "zebra_challenge",
                isActive: false, xCoordinate: 280.28, yCoordinate: 380.953,
                zPosition: 0.0, gameBackground: "lion_shape_background",
                level: AttributeLevel.EASY, nextChallenge: "elephant_challenge")
        ]

        return challenges
    }
}
