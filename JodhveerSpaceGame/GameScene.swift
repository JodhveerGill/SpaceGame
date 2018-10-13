//
//  GameScene.swift
//  JodhveerSpaceGame
//
//  Created by Jodhveer Gill on 2018-10-12.
//  Copyright © 2018 Jodhveer Gill. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    var player: SKSpriteNode!
    let backdrop = SKSpriteNode(imageNamed: "spacebackground")
    var gameTimer:Timer!
    var obstacles = ["asteroid", "comet"]
    let asteroidcategory:UInt32 = 0x1 << 1
    let blastcategroy:UInt32 = 0x1 << 0
    
    
    override func didMove(to view: SKView) {
        
        let backdrop = SKSpriteNode(imageNamed: "spacebackground")
        backdrop.position = CGPoint(x: 0, y: 0)
        addChild(backdrop)
        backdrop.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "spaceship")
        player.position = CGPoint(x: 0, y: self.frame.size.height/2 - 1000)
        self.addChild(player)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAsteroid), userInfo: nil, repeats: true)
        
    }
    
    @objc func addAsteroid (){
        
        obstacles = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: obstacles) as! [String]
        
        let gameobstacles = SKSpriteNode(imageNamed: obstacles[0])
        
        let randomObstaclePosition = GKRandomDistribution(lowestValue: -400, highestValue: 400)
        
        let position = CGFloat(randomObstaclePosition.nextInt())
        
        gameobstacles.position = CGPoint(x: position, y: self.frame.height + gameobstacles.size.height)
        
        gameobstacles.physicsBody = SKPhysicsBody(rectangleOf: gameobstacles.size)
        gameobstacles.physicsBody?.isDynamic = true
        
        gameobstacles.physicsBody?.categoryBitMask = asteroidcategory
        gameobstacles.physicsBody?.contactTestBitMask = blastcategroy
        gameobstacles.physicsBody?.collisionBitMask = 0
        
        self.addChild(gameobstacles)
        let animationduration:TimeInterval = 6
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -gameobstacles.size.height - 640), duration: animationduration))
        actionArray.append(SKAction.removeFromParent())
        
        gameobstacles.run(SKAction.sequence(actionArray))
        
        
        
    }
    
    func fireblast() {
        
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}








