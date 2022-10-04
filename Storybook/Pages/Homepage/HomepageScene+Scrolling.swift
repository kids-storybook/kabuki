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
        
//        scrollView.center = CGPoint(x: frame.midX, y: frame.midY)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * Config.scrollViewWidthAdjuster, height: scrollView.frame.height) // * 3 makes it three times as wide as screen
        view?.addSubview(scrollView)
        
        // Set scrollView to first page
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * (Config.scrollViewWidthAdjuster - 1), y: 0), animated: true)
        
        var spriteMapPosition = CGPoint()
        
        // ScrollView Sprites for each content in scrollView
        for (idx, item) in Theme.allValues.enumerated() {
            let spriteMap = SKSpriteNode(imageNamed: item.rawValue)
            spriteMap.name = item.rawValue
            if idx == 0 {
                // Makes positioning much easier.
                spriteMap.position = CGPoint(x: frame.midX - (scrollView.frame.width * 2), y: frame.midY)
            } else {
                spriteMap.position = CGPoint(x: spriteMapPosition.x + (spriteMap.size.width * 0.8), y: spriteMapPosition.y)
            }
            spriteMap.zPosition = 0
            spriteMapPosition = spriteMap.position
            moveableNode.addChild(spriteMap)
        }
    }
}
