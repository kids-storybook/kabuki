//
//  Button.swift
//  Storybook
//
//  Created by zy on 29/09/22.
//

import Foundation
import SpriteKit

class ButtonNode: SKSpriteNode {

    let onButtonPress: () -> Void

    init(iconName: String, text: String, onButtonPress: @escaping () -> Void) {

        self.onButtonPress = onButtonPress

        let texture = SKTexture(imageNamed: "button")
        super.init(texture: texture, color: SKColor.white, size: texture.size())

        let icon = SKSpriteNode(imageNamed: iconName)
        icon.position = CGPoint(x: -size.width * 0.25, y: 0)
        icon.zPosition = 1
        self.addChild(icon)

        let label = SKLabelNode(fontNamed: "Courier-Bold")
        label.fontSize = 50
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width * 0.25, y: 0)
        label.zPosition = 1
        label.verticalAlignmentMode = .center
        label.text = text
        self.addChild(label)

        isUserInteractionEnabled = true

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(0.9)
        onButtonPress()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
