//
//  HomepageScene+Scrolling.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import SpriteKit

extension HomepageScene {
    func prepareHorizontalScrolling() {
        // Attention, actually I dont really understand about scaling
        // things in here especially contentSizeWidthScale variable.
        // Please don't change anything from here except u already ask me first. -Jay

        // Set up scrollView
        scrollView = SwiftySKScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height),
                                        moveableNode: moveableNode, direction: .horizontal)

        guard let scrollView = scrollView else { return }

        var contentSizeWidthScale: CGFloat = 2.5
        if themes.count > 4 {
            contentSizeWidthScale = CGFloat(themes.count-1)
        }
        scrollView.contentSize = CGSize(
            width: scrollView.frame.width * contentSizeWidthScale,
            height: scrollView.frame.height) // * 3 makes it three times as wide as screen
        view?.addSubview(scrollView)

        // Set scrollView to first page
        scrollView.setContentOffset(CGPoint(
            x: scrollView.frame.width * CGFloat(contentSizeWidthScale-1),
            y: 0), animated: true
        )

        var spriteMapPosition = CGPoint(
            x: frame.midX - (scrollView.frame.width * CGFloat(contentSizeWidthScale-1)),
            y: frame.midY
        )

        // ScrollView Sprites for each content in scrollView
        for item in themes {
            if let themeAssets = item {
                let container = SKNode()

                // Add map using entity-component logic
                let spriteMap = Map(
                    themeAssets: themeAssets,
                    mapName: item?.name ?? "",
                    mapPosition: spriteMapPosition,
                    frame: frame
                )

                let tempPosition = spriteMapPosition

                if let spriteComponent = spriteMap.component(ofType: SpriteComponent.self) {
                    spriteMapPosition = CGPoint(
                        x: spriteMapPosition.x + (spriteComponent.node.size.width*1.2),
                        y: spriteMapPosition.y
                    )
                    container.addChild(spriteComponent.node)
                }

                if let texture = view?.texture(from: container) {
                    let sprite = SKSpriteNode(texture: texture)
                    sprite.name = item?.name
                    sprite.position = CGPoint(x: tempPosition.x, y: tempPosition.y)
                    moveableNode.addChild(sprite)
                }
            }
        }
    }
}
