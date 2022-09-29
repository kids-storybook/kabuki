//
//  Button.swift
//  Storybook
//
//  Created by zy on 29/09/22.
//

import Foundation
import SpriteKit

protocol ButtonDelegate: AnyObject {
    func buttonClicked(sender: Button)
}

class Button: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: ButtonDelegate!
    var soundEffect = SKAudioNode(fileNamed: "button-click.mp3")

    override init(texture: SKTexture?, color: SKColor, size: CGSize) {

        super.init(texture: texture, color: color, size: size)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        isUserInteractionEnabled = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(0.9)
        addChild(soundEffect)
        self.delegate.buttonClicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
        soundEffect.run(SKAction.stop())
    }
}
