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
    var title: String?
    var labels: [NSString?]
    var labelColor: StoryLabelColor?
    var order: Int32
    var background: String?
    var character: String?
    var characterAtlas: String?
    var characterXPosition: Double?
    var characterYPosition: Double?
}

struct ChallangeModel {
    var background: String?
    var challengeName: String?
    var isActive: Bool?
    var xCoordinate: Double?
    var yCoordinate: Double?
    var zPosition: Double?
    var gameBackground: String?
    var level: AttributeLevel?
    var nextChallenge: String?
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

struct AnimationModel {
    var challengeName: String?
    var shapeImage: String?
    var xCoordinateShape: Double?
    var yCoordinateShape: Double?
    //    var fontColor: UIColor?
    var shapeName: String?
    var xCoordinateFont: Double?
    var yCoordinateFont: Double?
}

enum AttributeLevel: String {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

enum StoryLabelColor: String {
    case green = "greenSingaLabel"
    case brown = "brownGajahLabel"
}

let initThemeData: [ThemeModel] = [
    ThemeModel(background: "mini zoo theme", mapBackground: "zoo_background", name: "zoo", isActive: true, challenges: [
        ChallangeModel(background: "bright_elephant_cage", challengeName: "elephant_challenge", isActive: false, xCoordinate: -545.187, yCoordinate: 165.877, zPosition: 1.0, gameBackground: "elephant_shape_background", level: AttributeLevel.medium, nextChallenge: "elephant_challenge"),
        ChallangeModel(background: "bright_gorilla_cage", challengeName: "gorilla_challenge", isActive: false, xCoordinate: 524.09, yCoordinate: 179.16, zPosition: 0.0, gameBackground: "lion_shape_background", level: AttributeLevel.easy, nextChallenge: "elephant_challenge"),
        ChallangeModel(background: "bright_giraffe_cage", challengeName: "giraffe_challenge", isActive: false, xCoordinate: 445.219, yCoordinate: -183.736, zPosition: 1.0, gameBackground: "lion_shape_background", level: AttributeLevel.easy, nextChallenge: "elephant_challenge"),
        ChallangeModel(background: "bright_panda_cage", challengeName: "panda_challenge", isActive: false, xCoordinate: -327.585, yCoordinate: 379.641, zPosition: 0.0, gameBackground: "lion_shape_background", level: AttributeLevel.easy, nextChallenge: "elephant_challenge"),
        ChallangeModel(background: "bright_penguin_cage", challengeName: "penguin_challenge", isActive: false, xCoordinate: 49.005, yCoordinate: 49.594, zPosition: 1.0, gameBackground: "lion_shape_background", level: AttributeLevel.easy, nextChallenge: "elephant_challenge"),
        ChallangeModel(background: "bright_lion_cage", challengeName: "lion_challenge", isActive: true, xCoordinate: -480.944, yCoordinate: -215.175, zPosition: 2.0, gameBackground: "lion_shape_background", level: AttributeLevel.easy, nextChallenge: "elephant_challenge"),
        ChallangeModel(background: "bright_zebra_cage", challengeName: "zebra_challenge", isActive: false, xCoordinate: 362.28, yCoordinate: 349.953, zPosition: 0.0, gameBackground: "lion_shape_background", level: AttributeLevel.easy, nextChallenge: "elephant_challenge")
    ]),
    ThemeModel(background: "locked theme", mapBackground: "zoo_background", name: "forest", isActive: false, challenges: []),
    ThemeModel(background: "locked theme", mapBackground: "zoo_background", name: "garden", isActive: false, challenges: []),
]

let initAssessmentData: [StoryModel] = [
    StoryModel(challengeName: "lion_challenge", title: "singaStoryTitle", labels: ["Lihatlah keluarga singa ini"], labelColor: StoryLabelColor.green, order: 0, background: "kandangSinga", character: "lions_1", characterAtlas: "LionStoryAnimation", characterXPosition: 0, characterYPosition: -50),
    StoryModel(challengeName: "lion_challenge", title: "singaStoryTitle", labels: ["Ada Bapak singa, Ibu singa, dan", "anak singa"], labelColor: StoryLabelColor.green, order: 1, background: "kandangSinga", character: "lions_1", characterXPosition: 0, characterYPosition: -50),
    StoryModel(challengeName: "lion_challenge_animate", title: "singaStoryTitle", labels: ["Ibu Singa memberikan anaknya", "berbagai bentuk mainan"], labelColor: StoryLabelColor.green, order: 0, background: "kandangSingaZoom", character: "lions_2", characterXPosition: -80, characterYPosition: -75),
    StoryModel(challengeName: "lion_challenge_animate_2", title: "singaStoryTitle", labels: ["Ada yang berbentuk persegi,", "segitiga, dan lingkaran"], labelColor: StoryLabelColor.green, order: 0, background: "kandangSingaZoom", character: "lions_2", characterXPosition: -80, characterYPosition: -75),
    StoryModel(challengeName: "lion_challenge_appreciation", title: "berhasilTitle", labels: ["appreciate"], labelColor: StoryLabelColor.green, order: 0, background: "kandangSinga", character: "lion_appreciation", characterXPosition: 30, characterYPosition: -120),
    
    
    StoryModel(challengeName: "elephant_challenge", title: "gajahStoryTitle", labels: ["Lihatlah sekelompok gajah ini"], labelColor: StoryLabelColor.brown, order: 0, background: "kandangGajah", character: "elephants_1", characterAtlas: "ElephantStoryAnimation", characterXPosition: 0, characterYPosition: 0),
    StoryModel(challengeName: "elephant_challenge", title: "gajahStoryTitle", labels: ["Mereka sedang diberi makan", "oleh penjaga kebun binatang "], labelColor: StoryLabelColor.brown, order: 1, background: "kandangGajah", character: "elephants_2", characterXPosition: 0, characterYPosition: 0),
    StoryModel(challengeName: "elephant_challenge_animate", title: "gajahStoryTitle", labels: ["Gajah adalah pemakan tumbuhan"], labelColor: StoryLabelColor.brown, order: 0, background: "kandangGajahZoom", character: "elephants_2", characterXPosition: 0, characterYPosition: 0),
    StoryModel(challengeName: "elephant_challenge_animate_2", title: "gajahStoryTitle", labels: ["Ada makanan yang berbentuk", "persegi, segitiga, dan lingkaran"], labelColor: StoryLabelColor.brown, order: 0, background: "kandangGajahZoom", character: "elephants_2", characterXPosition: 0, characterYPosition: 0),
    StoryModel(challengeName: "elephant_challenge_appreciation", title: "berhasilTitle", labels: ["appreciate"], labelColor: StoryLabelColor.brown, order: 0, background: "kandangGajahZoom", character: "elephant_appreciation", characterXPosition: -25, characterYPosition: -35)
    
]

let initShapeData: [ShapeModel] = [
    ShapeModel(challengeName: "lion_challenge", background: "lion_triangle_1", order: 0),
    ShapeModel(challengeName: "lion_challenge", background: "lion_circle_2", order: 1),
    ShapeModel(challengeName: "lion_challenge", background: "lion_triangle_3", order: 2),
    ShapeModel(challengeName: "lion_challenge", background: "lion_circle_1", order: 0),
    ShapeModel(challengeName: "lion_challenge", background: "lion_triangle_2", order: 1),
    ShapeModel(challengeName: "lion_challenge", background: "lion_square_3", order: 2),
    ShapeModel(challengeName: "lion_challenge", background: "lion_square_1", order: 0),
    ShapeModel(challengeName: "lion_challenge", background: "lion_square_2", order: 1),
    ShapeModel(challengeName: "lion_challenge", background: "lion_circle_3", order: 2),
    
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_triangle_1", order: 0),
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_square_2", order: 0),
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_triangle_3", order: 0),
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_circle_1", order: 0),
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_circle_2", order: 0),
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_triangle_2", order: 0),
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_square_1", order: 0),
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_circle_3", order: 0),
    ShapeModel(challengeName: "elephant_challenge", background: "elephant_square_3", order: 0),
]

let initShapeTargetData: [ShapeTargetModel] = [
    ShapeTargetModel(challengeName: "lion_challenge", background: "lion_triangle_target",
                     xCoordinate: 417, yCoordinate: -288, zPosition: 0.0),
    ShapeTargetModel(challengeName: "lion_challenge", background: "lion_square_target",
                     xCoordinate: 412, yCoordinate: 18.5, zPosition: 0.0),
    ShapeTargetModel(challengeName: "lion_challenge", background: "lion_circle_target",
                     xCoordinate: 410.5, yCoordinate: 309, zPosition: 0.0),
    ShapeTargetModel(challengeName: "elephant_challenge", background: "elephant_triangle_target",
                     xCoordinate: 417, yCoordinate: -288, zPosition: 0.0),
    ShapeTargetModel(challengeName: "elephant_challenge", background: "elephant_square_target",
                     xCoordinate: 0, yCoordinate: -288, zPosition: 0.0),
    ShapeTargetModel(challengeName: "elephant_challenge", background: "elephant_circle_target",
                     xCoordinate: -417, yCoordinate: -288, zPosition: 0.0),
]

let initAnimationData: [AnimationModel] = [
    AnimationModel(challengeName: "lion_challenge", shapeImage: "lion_square_3", xCoordinateShape: -265, yCoordinateShape: -245, shapeName: "Persegi", xCoordinateFont: -263, yCoordinateFont: 0),
    AnimationModel(challengeName: "lion_challenge", shapeImage: "lion_triangle_1", xCoordinateShape: -25, yCoordinateShape: -232, shapeName: "Segitiga", xCoordinateFont: -23, yCoordinateFont: 0),
    AnimationModel(challengeName: "lion_challenge", shapeImage: "lion_circle_1", xCoordinateShape: 204, yCoordinateShape: -235, shapeName: "Lingkaran", xCoordinateFont: 196, yCoordinateFont: 0),
    
    AnimationModel(challengeName: "elephant_challenge", shapeImage: "square_grass", xCoordinateShape: -265, yCoordinateShape: -245, shapeName: "Persegi", xCoordinateFont: -263, yCoordinateFont: 0),
    AnimationModel(challengeName: "elephant_challenge", shapeImage: "triangle_grass", xCoordinateShape: -25, yCoordinateShape: -250, shapeName: "Segitiga", xCoordinateFont: -23, yCoordinateFont: 0),
    AnimationModel(challengeName: "elephant_challenge", shapeImage: "circle_grass", xCoordinateShape: 204, yCoordinateShape: -235, shapeName: "Lingkaran", xCoordinateFont: 196, yCoordinateFont: 0)
]
