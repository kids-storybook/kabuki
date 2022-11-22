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
