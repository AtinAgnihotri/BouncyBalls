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
        addBouncers()
    }
    
    func addBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -2
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    func addBouncers() {
        let bouncerPoints = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: 256, y: 0),
            CGPoint(x: 512, y: 0),
            CGPoint(x: 768, y: 0),
            CGPoint(x: 1024, y: 0),
        ]
        var isGoodSlot = true
        // Add Bouncers
        for point in bouncerPoints {
            addBouncer(at: point)
        }
        // Add slots
        for indx in 1..<bouncerPoints.count {
            let leadingBouncerX = bouncerPoints[indx - 1].x
            let trailingBouncerX = bouncerPoints[indx].x
            let x = (leadingBouncerX + trailingBouncerX) / 2
            let midPoint = CGPoint(x: x, y: 0)
            addSlot(at: midPoint, isGood: isGoodSlot)
            isGoodSlot.toggle()
        }
    }
    
    func addBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
//        bouncer.physicsBody?.restitution = 0.8
        
        addChild(bouncer)
    }
    
    func addSlot(at position: CGPoint, isGood: Bool) {
        // Add Slot base
        let slotBaseType = isGood ? "slotBaseGood" : "slotBaseBad"
        let slotBase = SKSpriteNode(imageNamed: slotBaseType)
        slotBase.position = position
        addChild(slotBase)
        
        // Add Slot glow
        let slotGlowType = isGood ? "slotGlowGood" : "slotGlowBad"
        let slotGlow = SKSpriteNode(imageNamed: slotGlowType)
        slotGlow.position = position
        addChild(slotGlow)
        
        // Add Unending slow rotation to glow
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
//        addBox(at: location)
        addBall(named: "ballRed", at: location)
    }
    
    func addBox(at location: CGPoint) {
        let size = CGSize(width: 64, height: 64)
        let box = SKSpriteNode(color: .red, size: size)
        box.physicsBody = SKPhysicsBody(rectangleOf: size)
        box.position = location
        addChild(box)
    }
    
    func addBall(named ballName: String, at location: CGPoint) {
        let ball = SKSpriteNode(imageNamed: ballName)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.restitution = 0.4
        ball.position = location
        
        addChild(ball)
    }
    
}
