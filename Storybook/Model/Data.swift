//
//  Data.swift
//  Storybook
//
//  Created by zy on 24/10/22.
//

import Foundation

import UIKit

struct ThemeModel {
    var background: String?
    var mapBackground: String?
    var label: String?
    var name: String?
    var startButton: String?
    var isActive: Bool?
    var challenges: [ChallangeModel?]
}

struct StoryModel {
    var challengeName: String?
    var labels: [NSString?]
    var order: Int32
    var background: String?
    var character: String?
}

struct ChallangeModel {
    var background: String?
    var challengeName: String?
    var isActive: Bool?
    var xCoordinate: Double?
    var yCoordinate: Double?
    var zPosition: Double?
    var gameBackground: String?
}

struct ShapeModel {
    var challengeName: String?
    var background: String?
    var order: Int32
}

struct ShapeTargetModel {
    var challengeName: String?
    var background: String?
    var xCoordinate: Double?
    var yCoordinate: Double?
    var zPosition: Double?
}

let initThemeData: [ThemeModel] = [
    ThemeModel(background: "mini zoo card", mapBackground: "zoo_background", label: "mini zoo", name: "zoo", startButton: "start button", isActive: true, challenges: [
        ChallangeModel(background: "bright_elephant_cage", challengeName: "elephant_challenge", isActive: true, xCoordinate: -452.187, yCoordinate: 166.877, zPosition: 1.0, gameBackground: "zoo_background"),
        ChallangeModel(background: "bright_gorilla_cage", challengeName: "gorilla_challenge", isActive: false, xCoordinate: 524.09, yCoordinate: 179.16, zPosition: 0.0, gameBackground: "EasyGameScene"),
        ChallangeModel(background: "bright_giraffe_cage", challengeName: "giraffe_challenge", isActive: false, xCoordinate: 401.719, yCoordinate: -127.736, zPosition: 1.0, gameBackground: "EasyGameScene"),
        ChallangeModel(background: "bright_panda_cage", challengeName: "panda_challenge", isActive: false, xCoordinate: -327.585, yCoordinate: 379.641, zPosition: 0.0, gameBackground: "EasyGameScene"),
        ChallangeModel(background: "bright_penguin_cage", challengeName: "penguin_challenge", isActive: false, xCoordinate: 49.005, yCoordinate: 49.594, zPosition: 1.0, gameBackground: "EasyGameScene"),
        ChallangeModel(background: "bright_lion_cage", challengeName: "lion_challenge", isActive: true, xCoordinate: -402.944, yCoordinate: -188.175, zPosition: 2.0, gameBackground: "EasyGameScene"),
        ChallangeModel(background: "bright_zebra_cage", challengeName: "zebra_challenge", isActive: false, xCoordinate: 362.28, yCoordinate: 349.953, zPosition: 0.0, gameBackground: "EasyGameScene")
    ]),
    ThemeModel(background: "empty card", mapBackground: "zoo_background", label: "mini zoo", name: "forest", startButton: "start button", isActive: false, challenges: []),
    ThemeModel(background: "empty card", mapBackground: "zoo_background", label: "mini zoo", name: "garden", startButton: "start button", isActive: false, challenges: []),
]

let initAssessmentData: [StoryModel] = [
    StoryModel(challengeName: "lion_challenge", labels: ["Lihatlah keluarga singa ini"], order: 0, background: "kandangSinga", character: "lions_1"),
    StoryModel(challengeName: "lion_challenge", labels: ["Ada Bapak singa, Ibu singa, dan", "anak singa"], order: 1, background: "kandangSinga", character: "lions_1"),
    StoryModel(challengeName: "lion_challenge_animate", labels: ["Ibu Singa memberikan anaknya", "berbagai bentuk mainan"], order: 0, background: "kandangSingaZoom", character: "lions_2"),
    StoryModel(challengeName: "lion_challenge_animate_2", labels: ["Ada yang berbentuk lingkaran,", "persegi, dan segitiga"], order: 0, background: "kandangSingaZoom", character: "lions_2"),
    
    
    StoryModel(challengeName: "elephant_challenge", labels: ["Lihatlah keluarga singa ini"], order: 0, background: "kandangSinga", character: "Elephant"),
    StoryModel(challengeName: "elephant_challenge", labels: ["Ada Bapak singa, Ibu singa, dan", "anak singa"], order: 1, background: "kandangSinga", character: "kandangSinga"),
    StoryModel(challengeName: "elephant_challenge_animate", labels: ["Ibu Singa memberikan anaknya", "berbagai bentuk mainan"], order: 0, background: "kandangSingaZoom", character: "kandangSinga"),
    StoryModel(challengeName: "elephant_challenge_animate_2", labels: ["Ada yang berbentuk lingkaran,", "persegi, dan segitiga"], order: 0, background: "kandangSingaZoom", character: "kandangSinga")
    
]

let initShapeData: [ShapeModel] = [
    ShapeModel(challengeName: "lion_challenge", background: "triangle_1", order: 0),
    ShapeModel(challengeName: "lion_challenge", background: "triangle_2", order: 1),
    ShapeModel(challengeName: "lion_challenge", background: "triangle_3", order: 2),
    ShapeModel(challengeName: "lion_challenge", background: "circle_1", order: 0),
    ShapeModel(challengeName: "lion_challenge", background: "circle_2", order: 1),
    ShapeModel(challengeName: "lion_challenge", background: "circle_3", order: 2),
    ShapeModel(challengeName: "lion_challenge", background: "square_1", order: 0),
    ShapeModel(challengeName: "lion_challenge", background: "square_2", order: 1),
    ShapeModel(challengeName: "lion_challenge", background: "square_3", order: 2),
]

let initShapeTargetData: [ShapeTargetModel] = [
    ShapeTargetModel(challengeName: "lion_challenge", background: "triangle",
                     xCoordinate: 426.6, yCoordinate: -290, zPosition: 0.0),
    ShapeTargetModel(challengeName: "lion_challenge", background: "square",
                     xCoordinate: 426.6, yCoordinate: 9, zPosition: 0.0),
    ShapeTargetModel(challengeName: "lion_challenge", background: "circle",
                     xCoordinate: 422.331, yCoordinate: 309, zPosition: 0.0),
]
