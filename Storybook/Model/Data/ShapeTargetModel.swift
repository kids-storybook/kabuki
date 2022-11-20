//
//  ShapeTargetModel.swift
//  Storybook
//
//  Created by zy on 18/11/22.
//

import Foundation

struct ShapeTargetModel {
    var challengeName: String?
    var background: String?
    var xCoordinate: Double?
    var yCoordinate: Double?
    var zPosition: Double?
    var order: Int32?

    func feedingShapeTargets() -> [ShapeTargetModel] {
        let shapeTargets = [
            ShapeTargetModel(challengeName: "lion_challenge", background: "lion_triangle_target",
                             xCoordinate: 417, yCoordinate: -288, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "lion_challenge", background: "lion_square_target",
                             xCoordinate: 412, yCoordinate: 18.5, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "lion_challenge", background: "lion_circle_target",
                             xCoordinate: 410.5, yCoordinate: 309, zPosition: 10.0, order: 0),

            ShapeTargetModel(challengeName: "elephant_challenge", background: "elephant_triangle_target",
                             xCoordinate: 417, yCoordinate: -288, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "elephant_challenge", background: "elephant_square_target",
                             xCoordinate: 0, yCoordinate: -288, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "elephant_challenge", background: "elephant_circle_target",
                             xCoordinate: -417, yCoordinate: -288, zPosition: 10.0, order: 0),

            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_trianglebigup_target",
                             xCoordinate: 373.86, yCoordinate: 87.5, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_trianglesmalldown_target",
                             xCoordinate: 438.5, yCoordinate: 143.925, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_trianglesmalldown_target_2",
                             xCoordinate: 501.359, yCoordinate: 31.5, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_trianglesmallup_target",
                             xCoordinate: 563.86, yCoordinate: 31.5, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_trianglesmallup_target_2",
                             xCoordinate: 502.359, yCoordinate: 142.5, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_square_target",
                             xCoordinate: 374.859, yCoordinate: -88.5, zPosition: 10.0, order: 0),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_square_target_2",
                             xCoordinate: 503.859, yCoordinate: -88.5, zPosition: 10.0, order: 0),

            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_circle_target",
                             xCoordinate: 302.199, yCoordinate: -84.5, zPosition: 20.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_circle_target_2",
                             xCoordinate: 506.867, yCoordinate: -84.5, zPosition: 20.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_squarebig_target",
                             xCoordinate: 304.068, yCoordinate: -34.784, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_squarebig_target_2",
                             xCoordinate: 406.43, yCoordinate: -34.784, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_squarebig_target_3",
                             xCoordinate: 508.867, yCoordinate: -34.784, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_squaresmall_target",
                             xCoordinate: 227.917, yCoordinate: -8.425, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_squaresmall_target_2",
                             xCoordinate: 227.917, yCoordinate: -59.094, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_squaresmall_target_3",
                             xCoordinate: 584.944, yCoordinate: -8.425, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_squaresmall_target_4",
                             xCoordinate: 584.944, yCoordinate: -59.094, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_triangledown_target",
                             xCoordinate: 399.628, yCoordinate: 60.579, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_triangleup_target",
                             xCoordinate: 349.86, yCoordinate: 60.579, zPosition: 10.0, order: 1),
            ShapeTargetModel(challengeName: "panda_challenge", background: "panda_triangleup_target_2",
                             xCoordinate: 450.346, yCoordinate: 60.579, zPosition: 10.0, order: 1)
        ]

        return shapeTargets
    }
}
