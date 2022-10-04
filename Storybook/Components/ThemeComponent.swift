//
//  ThemeComponent.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import Foundation
import SpriteKit
import GameplayKit

enum Theme: String {
  case theme1 = "mini zoo card"
  case theme2 = "empty card"
  case theme3 = "empty card 1"

  static let allValues = [theme1, theme2, theme3]
}

class ThemeComponent: GKComponent {
  let theme: Theme
  
  init(theme: Theme) {
    self.theme = theme
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

