//
//  GameScene.swift
//  BouncyBalls
//
//  Created by Atin Agnihotri on 23/07/21.
//

import SpriteKit


class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        addBackground()
    }
    
    func addBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let size = CGSize(width: 64, height: 64)
        let box = SKSpriteNode(color: .red, size: size)
        box.physicsBody = SKPhysicsBody(rectangleOf: size)
        box.position = location
        addChild(box)
    }
    
}
