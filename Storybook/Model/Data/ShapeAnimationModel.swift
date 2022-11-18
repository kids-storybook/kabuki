//
//  AnimationModel.swift
//  Storybook
//
//  Created by zy on 18/11/22.
//

import Foundation

struct ShapeAnimationModel {
    var challengeName: String?
    var shapeImage: String?
    var xCoordinateShape: Double?
    var yCoordinateShape: Double?
    var shapeName: String?
    var xCoordinateFont: Double?
    var yCoordinateFont: Double?
    
    func feedingShapeAnimations() -> [ShapeAnimationModel] {
        let shapeAnimations = [
            ShapeAnimationModel(challengeName: "lion_challenge", shapeImage: "lion_square_3", xCoordinateShape: -265, yCoordinateShape: -245, shapeName: "Persegi", xCoordinateFont: -263, yCoordinateFont: 0),
            ShapeAnimationModel(challengeName: "lion_challenge", shapeImage: "lion_triangle_1", xCoordinateShape: -25, yCoordinateShape: -232, shapeName: "Segitiga", xCoordinateFont: -23, yCoordinateFont: 0),
            ShapeAnimationModel(challengeName: "lion_challenge", shapeImage: "lion_circle_1", xCoordinateShape: 204, yCoordinateShape: -235, shapeName: "Lingkaran", xCoordinateFont: 196, yCoordinateFont: 0),
            
            ShapeAnimationModel(challengeName: "elephant_challenge", shapeImage: "square_grass", xCoordinateShape: -265, yCoordinateShape: -245, shapeName: "Persegi", xCoordinateFont: -263, yCoordinateFont: 0),
            ShapeAnimationModel(challengeName: "elephant_challenge", shapeImage: "triangle_grass", xCoordinateShape: -25, yCoordinateShape: -250, shapeName: "Segitiga", xCoordinateFont: -23, yCoordinateFont: 0),
            ShapeAnimationModel(challengeName: "elephant_challenge", shapeImage: "circle_grass", xCoordinateShape: 204, yCoordinateShape: -235, shapeName: "Lingkaran", xCoordinateFont: 196, yCoordinateFont: 0),
            
            ShapeAnimationModel(challengeName: "panda_challenge", shapeImage: "panda_square", xCoordinateShape: -195, yCoordinateShape: -245, shapeName: "Persegi", xCoordinateFont: -193, yCoordinateFont: 0),
            ShapeAnimationModel(challengeName: "panda_challenge", shapeImage: "panda_triangle", xCoordinateShape: 75, yCoordinateShape: -250, shapeName: "Segitiga", xCoordinateFont: 77, yCoordinateFont: 0),
            ShapeAnimationModel(challengeName: "panda_challenge", shapeImage: "panda_circle", xCoordinateShape: 322, yCoordinateShape: -235, shapeName: "Lingkaran", xCoordinateFont: 316, yCoordinateFont: 0)
        ]
        return shapeAnimations
    }
}
