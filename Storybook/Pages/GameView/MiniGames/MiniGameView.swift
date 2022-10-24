//
//  MiniGameView.swift
//  Storybook
//
//  Created by Leonard Fernando on 20/10/22.
//

import SpriteKit
import Foundation


class MiniGameView: SKScene {
    
    let backgroundScene = SKSpriteNode(imageNamed: "EasyGameScene")
    let lionCub = SKSpriteNode(imageNamed: "#1 Anak Singa")
    
    let label = SKLabelNode()
    var shape = SKSpriteNode()
    
    var triangle = SKSpriteNode()
    var square = SKSpriteNode()
    var circle = SKSpriteNode()
    
    let squareBin = SKSpriteNode()
    let triangleBin = SKSpriteNode()
    let circleBin = SKSpriteNode()
    
    let triangleBinTitle = SKLabelNode()
    let squareBinTitle = SKLabelNode()
    let circleBinTitle = SKLabelNode()
    
    var c = 0
    var s = 0
    var t = 0
    
    func setBackground() {
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        
        //QUESTION 1
        backgroundScene.setScale(0.65)
        backgroundScene.zPosition = -10
        addChild(backgroundScene)
        
        lionCub.position = CGPoint(x: frame.midX-150, y: frame.midY - 75)
        lionCub.setScale(0.2)
        lionCub.zPosition = -9
        addChild(lionCub)
    }
    
    
    func setupShapes() {
        //Create shapes
        //Triangle
        triangle = SKSpriteNode(texture: SKTexture(imageNamed: "T1"))
        triangle.name = "Triangle"
        triangle.setScale(0.15)
        triangle.position = CGPoint(x: frame.midX-275, y: frame.midY - 175)
        addChild(triangle)
        
        //Square
        square = SKSpriteNode(texture: SKTexture(imageNamed: "S1"))
        square.name = "Square"
        square.setScale(0.15)
        square.position = CGPoint(x: frame.midX-150, y: frame.midY - 175)
        addChild(square)
        
        //Circle
        circle = SKSpriteNode(texture: SKTexture(imageNamed: "C1"))
        circle.name = "Circle"
        circle.setScale(0.15)
        circle.position = CGPoint(x: frame.midX-25, y: frame.midY - 175)
        addChild(circle)
        
    }
    
    
    func setupTargets(){
        
        //setup the yellow bin with colour, dimensions and add to scene
        triangleBin.color = SKColor.yellow
        triangleBin.alpha = 0
        triangleBin.size = CGSize(width:100, height: 100)
        triangleBin.position = CGPoint (x: frame.midX + 245 , y: frame.midY - 165)
        triangleBin.zPosition = -1
        addChild(triangleBin)
        
        triangleBinTitle.fontName = "Chalkduster";
        triangleBinTitle.fontSize = 20
        triangleBinTitle.fontColor = SKColor.black
        triangleBinTitle.position = CGPoint (x: frame.midX + 245 , y: frame.midY - 175)
        triangleBinTitle.text = "Triangle"
        triangleBinTitle.zPosition = -1
        
        
        //note that we can determine property of a fixed type using shorthand, shown here for setting colour
        squareBin.color = SKColor.blue
        squareBin.alpha = 0
        squareBin.size = CGSize(width:100, height: 100)
        squareBin.position = CGPoint (x: frame.midX + 245, y: frame.midY)
        squareBin.zPosition = -1
        addChild(squareBin)
        
        squareBinTitle.fontName = "Chalkduster";
        squareBinTitle.fontSize = 20
        squareBinTitle.fontColor = SKColor.white
        squareBinTitle.position = CGPoint (x: frame.midX + 245, y: frame.midY)
        squareBinTitle.text = "Square"
        squareBinTitle.zPosition = -1
        
        //Circle Bin
        circleBin.color = SKColor.green
        circleBin.alpha = 0
        circleBin.size = CGSize(width:100, height: 100)
        circleBin.position = CGPoint (x: frame.midX + 240, y: frame.midY + 165)
        circleBin.zPosition = -1
        addChild(circleBin)
        
        circleBinTitle.fontName = "Chalkduster";
        circleBinTitle.fontSize = 20
        circleBinTitle.fontColor = SKColor.white
        circleBinTitle.position = CGPoint (x: frame.midX + 250, y: frame.midY + 175)
        circleBinTitle.text = "Circle"
        circleBinTitle.zPosition = -1
    }
    
    func wrongClick(){
        let wrongPopUp = SKLabelNode(fontNamed: "Chalkduster")
        wrongPopUp.text = "YAH SALAH, YUK COBA LAGE"
        wrongPopUp.fontSize = 48
        wrongPopUp.fontColor = SKColor.red
        wrongPopUp.position = CGPoint(x: frame.midX, y: frame.height/10)
        
        addChild(wrongPopUp)
        
        wrongPopUp.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.removeFromParent()
            ])
        )
    }
    
    public override func didMove(to view: SKView) {
        setBackground()
        setupShapes()
        setupTargets()
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //get a touch
        let touch = touches.first!
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        //if it started in the Shapes, move it to the new location
        if let name = node.name, name == square.name {
            square.position = touch.location(in:self)
        }
        else if let name = node.name, name == circle.name {
            circle.position = touch.location(in:self)
        }
        else if let name = node.name, name == triangle.name {
            triangle.position = touch.location(in:self)
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if shape is called triangle and its centre is inside the triangle target
        if triangle.name == "Triangle"{
            if triangleBin.frame.contains(triangle.position){
                //remove it and create a new label
                triangle.position = triangleBin.position
                t = t + 1
            }
            else if squareBin.frame.contains(triangle.position){
                wrongClick()
                triangle.run(
                    SKAction.sequence([
                        SKAction.scale(by: 0.5, duration: 0.15),
                        SKAction.wait(forDuration: 0.01),
                        SKAction.scale(by: 2, duration: 0.15)
                    ])
                )
                triangle.position = CGPoint(x: frame.midX-275, y: frame.midY - 175)
            }
            else if circleBin.frame.contains(triangle.position){
                wrongClick()
                triangle.run(
                    SKAction.sequence([
                        SKAction.scale(by: 0.5, duration: 0.15),
                        SKAction.wait(forDuration: 0.01),
                        SKAction.scale(by: 2, duration: 0.15)
                    ])
                )
                triangle.position = CGPoint(x: frame.midX-275, y: frame.midY - 175)
            }
        }
        
        //same process for square label
        if square.name == "Square"{
            if squareBin.frame.contains(square.position){
                //remove it and create a new label
                square.position = squareBin.position
                s = s + 1
            }
            else if triangleBin.frame.contains(square.position){
                square.run(
                    SKAction.sequence([
                        SKAction.scale(by: 0.5, duration: 0.15),
                        SKAction.wait(forDuration: 0.02),
                        SKAction.scale(by: 2, duration: 0.15)
                    ])
                )
                wrongClick()
                square.position = CGPoint(x: frame.midX-150, y: frame.midY - 175)
            }
            else if circleBin.frame.contains(square.position){
                square.run(
                    SKAction.sequence([
                        SKAction.scale(by: 0.5, duration: 0.15),
                        SKAction.wait(forDuration: 0.01),
                        SKAction.scale(by: 2, duration: 0.15)
                    ])
                )
                wrongClick()
                square.position = CGPoint(x: frame.midX-150, y: frame.midY - 175)
            }
        }
        
        //same process for circle label
        if circle.name == "Circle"{
            if circleBin.frame.contains(circle.position){
                //remove it and create a new label
                circle.position = circleBin.position
                c = c + 1
            }
            else if triangleBin.frame.contains(circle.position){
                circle.run(
                    SKAction.sequence([
                        SKAction.scale(by: 0.5, duration: 0.15),
                        SKAction.wait(forDuration: 0.02),
                        SKAction.scale(by: 2, duration: 0.15)
                    ])
                )
                wrongClick()
                circle.position = CGPoint(x: frame.midX-25, y: frame.midY - 175)
            }
            else if squareBin.frame.contains(circle.position){
                circle.run(
                    SKAction.sequence([
                        SKAction.scale(by: 0.5, duration: 0.15),
                        SKAction.wait(forDuration: 0.01),
                        SKAction.scale(by: 2, duration: 0.15)
                    ])
                )
                wrongClick()
                circle.position = CGPoint(x: frame.midX-25, y: frame.midY - 175)
            }
        }
        
        if c == 1 && t == 1 && s == 1 {
            
            
        }
        
    }
    
}
