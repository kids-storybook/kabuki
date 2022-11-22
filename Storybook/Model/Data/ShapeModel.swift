//
//  ShapeModel.swift
//  Storybook
//
//  Created by zy on 18/11/22.
//

import Foundation

struct ShapeModel {
    var challengeName: String?
    var background: String?
    var order: Int32?
    var xCoordinate: Double?
    var yCoordinate: Double?

    func feedingLionShapes() -> [ShapeModel] {
        let shapes = [
            ShapeModel(challengeName: "lion_challenge", background: "lion_triangle_1",
                       order: 0, xCoordinate: 0.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "lion_challenge", background: "lion_circle_2",
                       order: 1, xCoordinate: 0.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "lion_challenge", background: "lion_triangle_3",
                       order: 2, xCoordinate: 0.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "lion_challenge", background: "lion_circle_1",
                       order: 0, xCoordinate: -250.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "lion_challenge", background: "lion_triangle_2",
                       order: 1, xCoordinate: -250.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "lion_challenge", background: "lion_square_3",
                       order: 2, xCoordinate: -250.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "lion_challenge", background: "lion_square_1",
                       order: 0, xCoordinate: -500.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "lion_challenge", background: "lion_square_2",
                       order: 1, xCoordinate: -500.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "lion_challenge", background: "lion_circle_3",
                       order: 2, xCoordinate: -500.0, yCoordinate: -200.0)
        ]

        return shapes
    }

    func feedingElephantShapes() -> [ShapeModel] {
        let shapes = [
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_triangle_1",
                       order: 0, xCoordinate: -500.0, yCoordinate: 50.0),
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_square_2",
                       order: 0, xCoordinate: -250.0, yCoordinate: 50.0),
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_triangle_3",
                       order: 0, xCoordinate: 0.0, yCoordinate: 50.0),
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_circle_1",
                       order: 0, xCoordinate: 250.0, yCoordinate: 50.0),
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_circle_2",
                       order: 0, xCoordinate: 500.0, yCoordinate: 50.0),
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_triangle_2",
                       order: 0, xCoordinate: 91.5, yCoordinate: 230.0),
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_square_1",
                       order: 0, xCoordinate: -158.5, yCoordinate: 230.0),
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_circle_3",
                       order: 0, xCoordinate: -408.5, yCoordinate: 230.0),
            ShapeModel(challengeName: "elephant_challenge", background: "elephant_square_3",
                       order: 0, xCoordinate: 341.5, yCoordinate: 230.0)
        ]

        return shapes
    }

    func feedingPandaShapes() -> [ShapeModel] {
        let shapes = [
            ShapeModel(challengeName: "panda_challenge", background: "panda_square_1",
                       order: 0, xCoordinate: -100.0, yCoordinate: -360.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_square_2",
                       order: 0, xCoordinate: -250.0, yCoordinate: -360.0),

            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglesmallup_1",
                       order: 0, xCoordinate: -75.0, yCoordinate: -230.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglesmalldown_2",
                       order: 0, xCoordinate: -175.0, yCoordinate: -230.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglesmallup_2",
                       order: 0, xCoordinate: -275.0, yCoordinate: -230.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglesmalldown_1",
                       order: 0, xCoordinate: -375.0, yCoordinate: -230.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglebigup_1",
                       order: 0, xCoordinate: -475.0, yCoordinate: -300.0),

            ShapeModel(challengeName: "panda_challenge", background: "panda_circle_1",
                       order: 1, xCoordinate: -450.0, yCoordinate: -225.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_circle_2",
                       order: 1, xCoordinate: -450.0, yCoordinate: -375.0),

            ShapeModel(challengeName: "panda_challenge", background: "panda_squarebig_1",
                       order: 1, xCoordinate: -75.0, yCoordinate: -375.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squarebig_2",
                       order: 1, xCoordinate: -200.0, yCoordinate: -375.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squarebig_3",
                       order: 1, xCoordinate: -325.0, yCoordinate: -375.0),

            ShapeModel(challengeName: "panda_challenge", background: "panda_squaresmall_1",
                       order: 1, xCoordinate: -540.0, yCoordinate: -200.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squaresmall_2",
                       order: 1, xCoordinate: -540.0, yCoordinate: -250.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squaresmall_3",
                       order: 1, xCoordinate: -540.0, yCoordinate: -400.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squaresmall_4",
                       order: 1, xCoordinate: -540.0, yCoordinate: -350.0),

            ShapeModel(challengeName: "panda_challenge", background: "panda_triangledown_1",
                       order: 1, xCoordinate: -200.0, yCoordinate: -230.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_triangleup_1",
                       order: 1, xCoordinate: -100.0, yCoordinate: -230.0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_triangleup_2",
                       order: 1, xCoordinate: -300.0, yCoordinate: -230.0)
        ]

        return shapes
    }

    func feedingZooShapes() -> [ShapeModel] {
        var shapes: [ShapeModel] = []
        shapes += feedingLionShapes()
        shapes += feedingElephantShapes()
        shapes += feedingPandaShapes()

        return shapes
    }
}
