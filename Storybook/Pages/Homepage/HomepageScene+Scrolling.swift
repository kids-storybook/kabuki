//
//  HomepageScene+Scrolling.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import SpriteKit

extension HomepageScene {
    func prepareHorizontalScrolling() {
        // Set up scrollView
        scrollView = SwiftySKScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), moveableNode: moveableNode, direction: .horizontal)
        
        guard let scrollView = scrollView else { return }
        var contentSizeWidthScale: CGFloat = 2.5
        if Theme.allValues.count > 4 {
            contentSizeWidthScale = CGFloat(Theme.allValues.count-1)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.width * contentSizeWidthScale, height: scrollView.frame.height) // * 3 makes it three times as wide as screen
        view?.addSubview(scrollView)
        
        // Set scrollView to first page
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(contentSizeWidthScale-1), y: 0), animated: true)
        
        var spriteMapPosition = CGPoint(x: frame.midX - (scrollView.frame.width * CGFloat(contentSizeWidthScale-1)), y: frame.midY - 50)

        // ScrollView Sprites for each content in scrollView
        for (idx, item) in Theme.allValues.enumerated() {
            let themeAssets = Theme.allAssets[item]!
            let container = SKNode()
            let spriteMap = SKSpriteNode(imageNamed: themeAssets["background"]!)
            spriteMap.name = item
            if idx == 0 {
                spriteMap.position = spriteMapPosition
            } else {
                spriteMap.position = CGPoint(x: spriteMapPosition.x + (spriteMap.size.width*1.2), y: spriteMapPosition.y)
            }
                                             
            // Add start button + label for each map
            let startButton = SKSpriteNode(imageNamed: themeAssets["startButton"]!)
            startButton.position = CGPoint(x: frame.midX, y: spriteMap.frame.minY - (spriteMap.frame.minY*0.2))
            startButton.zPosition = 1
            startButton.name = item
            spriteMap.addChild(startButton)
            let labelMap = SKSpriteNode(imageNamed: themeAssets["label"]!)
            labelMap.position = CGPoint(x: frame.midX, y: spriteMap.frame.maxY + (spriteMap.frame.maxY*0.8))
            labelMap.zPosition = 1
            
            spriteMap.zPosition = 0
            spriteMapPosition = spriteMap.position
            container.addChild(spriteMap)
            
            if let texture = view?.texture(from: container) {
                let sprite = SKSpriteNode(texture:texture)
                sprite.name = item
                if idx == 0 {
                    sprite.position = spriteMapPosition
                } else {
                    sprite.position = CGPoint(x: spriteMapPosition.x, y: spriteMapPosition.y)
                }
                sprite.addChild(labelMap)
                moveableNode.addChild(sprite)
            }
            
            
        }
    }
}
