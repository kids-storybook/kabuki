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

    func feedingZooShapes() -> [ShapeModel] {
        let shapes = [
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

            ShapeModel(challengeName: "panda_challenge", background: "panda_square_1", order: 0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_square_2", order: 0),

            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglesmalldown_1", order: 0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglesmalldown_2", order: 0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglesmallup_1", order: 0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglesmallup_2", order: 0),
            ShapeModel(challengeName: "panda_challenge", background: "panda_trianglebigup_1", order: 0),

            ShapeModel(challengeName: "panda_challenge", background: "panda_circle_1", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_circle_2", order: 1),

            ShapeModel(challengeName: "panda_challenge", background: "panda_squarebig_1", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squarebig_2", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squarebig_3", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squaresmall_1", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squaresmall_2", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squaresmall_3", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_squaresmall_4", order: 1),

            ShapeModel(challengeName: "panda_challenge", background: "panda_triangledown_1", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_triangleup_1", order: 1),
            ShapeModel(challengeName: "panda_challenge", background: "panda_triangleup_2", order: 1)
        ]

        return shapes
    }
}
