//
//  ThemeComponent.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import Foundation
import SpriteKit
import GameplayKit

enum ThemeEnum: String {
    case theme1 = "zoo"
    case theme2 = "forest"
    case theme3 = "garden"
    
    static let allValues: [String] = [theme1.rawValue, theme2.rawValue, theme3.rawValue]
    static let allAssets: [String:[String:Any]] = [
        "zoo":[
            "background":"mini zoo card",
            "startButton":"start button",
            "label":"mini zoo",
            "isActive": true
        ],
        "forest":[
            "background":"empty card",
            "startButton":"start button",
            "label":"mini zoo",
            "isActive": false
        ],
        "garden":[
            "background":"empty card 1",
            "startButton":"start button",
            "label":"mini zoo",
            "isActive": false
        ],
    ]
    static let allMapAssets: [String:[String:Any]] = [
        "zoo":
            [
                "background":"zoo_background",
                "challenge_1": [
                    "background":"bright_elephant_cage",
                    "location":[-452.187, 166.877],
                    "zPosition": 1.0,
                    "isActive": false
                ],
                "challenge_2": [
                    "background":"bright_gorilla_cage",
                    "location":[524.09, 179.16],
                    "zPosition": 0.0,
                    "isActive": false
                ],
                "challenge_3": [
                    "background":"bright_giraffe_cage",
                    "location":[401.719, -127.736],
                    "zPosition": 1.0,
                    "isActive": false
                ],
                "challenge_4": [
                    "background":"bright_panda_cage",
                    "location":[-327.585, 379.641],
                    "zPosition": 0.0,
                    "isActive": false
                ],
                "challenge_5": [
                    "background":"bright_penguin_cage",
                    "location":[49.005, 49.594],
                    "zPosition": 1.0,
                    "isActive": false
                ],
                "challenge_6": [
                    "background":"bright_lion_cage",
                    "location":[-402.944, -188.175],
                    "zPosition": 2.0,
                    "isActive": true
                ],
                "challenge_7": [
                    "background":"bright_zebra_cage",
                    "location":[362.28, 349.953],
                    "zPosition": 0.0,
                    "isActive": false
                ]
            ],
    ]
    
    static let allGameViewAssets: [String:[String:Any]] = [
        "challenge_1": [
            "scene_1": [
                "labels": [
                    "Ini adalah keluarga Singa"
                ]
            ],
            "scene_2": [
                "labels": [
                    "Lihatlah keluarga singa ini",
                    "Ada Bapak singa, Ibu singa, dan anak singa"
                ]
            ]
        ]
        
    ]
}

class ThemeComponent: GKComponent {
    let theme: ThemeEnum
    
    init(theme: ThemeEnum) {
        self.theme = theme
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

