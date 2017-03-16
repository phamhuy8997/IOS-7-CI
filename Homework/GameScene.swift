//
//  GameScene.swift
//  SwiftLearning
//
//  Created by Huy Pham on 2/25/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import SpriteKit
import GameplayKit

struct Physicscategory {
    static let fly : UInt32 = 1
    static let player : UInt32 = 2
    static let playerBullets : UInt32 = 3
    static let flyBullets : UInt32 = 4
    static let flyBullets1 : UInt32 = 5
    
}
class GameScene: SKScene , SKPhysicsContactDelegate {
    
    let playerNode  = SKSpriteNode(imageNamed: "player-1.png")
    let flyNode = SKSpriteNode(imageNamed: "fly-1-1.png")
    let xFly : CGFloat = 100
    let screenSize = UIScreen.main.bounds
    var flies : [SKSpriteNode] = []
    
    var starfield:SKEmitterNode!
    var scoreLabel:SKLabelNode!
    var healthLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var heath:Int = 100 {
        didSet {
            healthLabel.text = "Health: \(heath)"
        }
    }
    let fly1Texture = SKTexture(imageNamed: "fly-1-1")
    let fly2Texture = SKTexture(imageNamed: "fly-1-2")
    let fly3Texture = SKTexture(imageNamed: "fly-3-1")
    let fly4Texture = SKTexture(imageNamed: "fly-3-2")
    let fly5Texture = SKTexture(imageNamed: "fly-3-3")
    let playerShootSoundAction = SKAction.playSoundFileNamed("player-shoot.wav", waitForCompletion: false)
    let playerDiedSound = SKAction.playSoundFileNamed("attack-1.wav", waitForCompletion: false)
    
    let extensionTexture0 = SKTexture(imageNamed: "explosion-0")
    let extensionTexture1 = SKTexture(imageNamed: "explosion-1")
    let extensionTexture2 = SKTexture(imageNamed: "explosion-2")
    let extensionTexture3 = SKTexture(imageNamed: "explosion-3")
    
    let playerTexture1 = SKTexture(imageNamed: "explosion-2-1")
    let playerTexture2 = SKTexture(imageNamed: "explosion-2-2")
    let playerTexture3 = SKTexture(imageNamed: "explosion-2-3")
    let playerTexture4 = SKTexture(imageNamed: "explosion-2-4")
    
    
    var playerBullets: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0, y: 0)
        
        addStarfield()
        addPlayer()
        configPhysics()
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 65, y: self.frame.size.height - 550)
        scoreLabel.fontSize = 25
        scoreLabel.fontColor = UIColor.yellow
        
        healthLabel = SKLabelNode(text: "Health: 100")
        healthLabel.position = CGPoint(x: self.frame.size.width - 60, y: self.frame.size.height - 550)
        healthLabel.fontSize = 25
        healthLabel.fontColor = UIColor.yellow

        
        score = 0
        heath = 10
        
        self.addChild(scoreLabel)
        self.addChild(healthLabel)
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(playerShoot), SKAction.wait(forDuration: 1.0)])))
        
        
        //texture => images
    }
    func addStarfield() -> Void {
        if let starfieldNode = SKEmitterNode(fileNamed: "starfield1.sks") {
            starfieldNode.position = CGPoint(x: self.size.width / 2, y: self.size.height)
            starfieldNode.zPosition = -100
            starfieldNode.particlePositionRange = CGVector(dx: self.size.width, dy: 0)
            addChild(starfieldNode)
        }

    }
    
    func configPhysics() -> Void {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let nodeA = bodyA.node
        let nodeB = bodyB.node
        
        if ((bodyA.categoryBitMask == Physicscategory.fly) && (bodyB.categoryBitMask == Physicscategory.playerBullets) || (bodyA.categoryBitMask == Physicscategory.playerBullets) && (bodyB.categoryBitMask == Physicscategory.fly))   {
            nodeA?.removeFromParent()
            nodeB?.removeFromParent()
            score += 2
//            if score == 50 {
//                let mh3 = GameScene1(size: self.size)
//                mh3.scaleMode = scaleMode
//                let reveal1 = SKTransition.fade(withDuration: 3)
//                self.view?.presentScene(mh3, transition: reveal1)
//            }
            
            addExplosion(position: (nodeA?.position)!)
        }
        
        if ((bodyA.categoryBitMask == Physicscategory.flyBullets) && (bodyB.categoryBitMask == Physicscategory.player) || (bodyA.categoryBitMask == Physicscategory.player) && (bodyB.categoryBitMask == Physicscategory.flyBullets)) || ((bodyA.categoryBitMask == Physicscategory.flyBullets1) && (bodyB.categoryBitMask == Physicscategory.player) || (bodyA.categoryBitMask == Physicscategory.player) && (bodyB.categoryBitMask == Physicscategory.flyBullets1)) {
            heath -= 1
            self.run(playerDiedSound)
            if heath == 0 {
                addPlayerExplosion(position: self.playerNode.position)
                self.playerNode.removeFromParent()
                let mh2 = ManHinh2Scene(size: self.size)
                mh2.scaleMode = scaleMode
                let reveal0 = SKTransition.fade(withDuration: 3)
                self.view?.presentScene(mh2, transition: reveal0)
            }
        }
        
    }
    
    func addExplosion(position: CGPoint) -> Void {
        let explosionNode = SKSpriteNode(imageNamed: "explosion-0")
        explosionNode.position = position
        let animateAction = SKAction.animate(with: [extensionTexture0, extensionTexture1, extensionTexture2, extensionTexture3], timePerFrame: 0.05)
        
        explosionNode.run(.sequence([animateAction, .removeFromParent()]))
        
        addChild(explosionNode)
    }
    
    func addPlayerExplosion(position: CGPoint) -> Void {
        let explosionPlayerNode = SKSpriteNode(imageNamed: "explosion-2-1")
        explosionPlayerNode.position = position
        let animateAction = SKAction.animate(with: [playerTexture1, playerTexture2, playerTexture2, playerTexture4], timePerFrame: 0.05)
        
        explosionPlayerNode.run(.sequence([animateAction, .removeFromParent()]))
        
        addChild(explosionPlayerNode)
    }

    func addPlayer() -> Void {
        playerNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        playerNode.size = CGSize(width: self.size.width / 10, height: self.size.height / 15)
        playerNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 10)
        playerNode.physicsBody = SKPhysicsBody(rectangleOf: playerNode.size)
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.linearDamping = 0
        playerNode.physicsBody?.categoryBitMask = Physicscategory.player
        playerNode.physicsBody?.contactTestBitMask = Physicscategory.flyBullets
        addChild(playerNode)
    }
    
    func addFlies(fiIndexWidth: Int, fiIndexHeight: Int) -> Void {
        let flyXMid : CGFloat = size.width / 2
        let flyIndexMid : CGFloat = 2
        flyNode.size = CGSize(width: self.size.width / 12, height: self.size.height / 17)
        
        for flyIndex in 0..<fiIndexHeight {
            for flyIndex1 in 0..<fiIndexWidth {
                let flyWidth : CGFloat = 20
                let flySpace : CGFloat = 20
                let SPACE = flyWidth + flySpace
                let flyX : CGFloat = flyXMid + (CGFloat(flyIndex) - flyIndexMid) * SPACE
                let flyY : CGFloat = size.height
                
                let flyNode = SKSpriteNode(imageNamed: "fly-1-1.png")
                flyNode.anchorPoint = CGPoint(x: 0.5, y: 1)
                flyNode.position = CGPoint(x: flyX, y: flyY - CGFloat(flyIndex1)*50)
                flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                
                var action = [SKAction]()
                action.append(SKAction.run {
                    self.flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                action.append(SKAction.moveTo(x:  flyNode.position.x + 100, duration: 3))
                action.append(SKAction.run {
                    self.flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                action.append(SKAction.moveTo(x: flyNode.position.x - 60, duration: 3))
                action.append(SKAction.run {
                    self.flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                flyNode.run(SKAction.repeatForever(SKAction.sequence(action)))
                
                flyNode.physicsBody = SKPhysicsBody(rectangleOf: flyNode.size)
                flyNode.physicsBody?.collisionBitMask = 0
                flyNode.physicsBody?.linearDamping = 0
                flyNode.physicsBody?.categoryBitMask = Physicscategory.fly
                flyNode.physicsBody?.contactTestBitMask = Physicscategory.playerBullets
                flyNode.physicsBody?.velocity = CGVector(dx: 0, dy: -40)
                
                //let animateAction : SKAction =
                flyNode.run(
                    .repeatForever(
                    .animate(with: [fly1Texture, fly2Texture], timePerFrame: 0.1)))
                addChild(flyNode)
            
                flies.append(flyNode)
            }
        }
        
    }
    
    func addFlies1(fiIndexWidth: Int, fiIndexHeight: Int) -> Void {
        let flyXMid : CGFloat = size.width / 2
        let flyIndexMid : CGFloat = 2
        
        for flyIndex in 0..<fiIndexHeight {
            for flyIndex1 in 0..<fiIndexWidth {
                let flyWidth : CGFloat = 40
                let flySpace : CGFloat = 60
                let SPACE = flyWidth + flySpace
                let flyX : CGFloat = flyXMid + (CGFloat(flyIndex) - flyIndexMid) * SPACE
                let flyY : CGFloat = size.height
                
                let flyNode = SKSpriteNode(imageNamed: "fly-3-1.png")
                flyNode.size = CGSize(width: self.size.width / 5, height: self.size.height / 10)
                flyNode.anchorPoint = CGPoint(x: 0.5, y: 1)
                flyNode.position = CGPoint(x: flyX, y: flyY - CGFloat(flyIndex1)*50)
                flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                
                var action = [SKAction]()
                action.append(SKAction.run {
                    self.flyShoot1(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                action.append(SKAction.moveTo(x:  flyNode.position.x + 200, duration: 2))
                action.append(SKAction.run {
                    self.flyShoot1(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                action.append(SKAction.moveTo(x: flyNode.position.x - 20, duration: 2))
                action.append(SKAction.run {
                    self.flyShoot1(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                flyNode.run(SKAction.repeatForever(SKAction.sequence(action)))
                
                flyNode.physicsBody = SKPhysicsBody(rectangleOf: flyNode.size)
                flyNode.physicsBody?.collisionBitMask = 0
                flyNode.physicsBody?.linearDamping = 0
                flyNode.physicsBody?.categoryBitMask = Physicscategory.fly
                flyNode.physicsBody?.contactTestBitMask = Physicscategory.playerBullets
                
                //let animateAction : SKAction =
                flyNode.run(
                    .repeatForever(
                        .animate(with: [fly3Texture, fly4Texture, fly5Texture], timePerFrame: 0.1)))
                addChild(flyNode)
                
                flies.append(flyNode)
            }
        }
        
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let location = firstTouch.location(in: self)
            print(location)
            playerNode.position.x = location.x
        }
        
    }
    
    var startTime: TimeInterval = -1
    var startTime1: TimeInterval = -1
    var countWidthIndex: Int = 1
    var countHeightIndex: Int = 1
    var countWidthIndex1: Int = 1
    var countHeightIndex1: Int = 1
    
    override func update(_ currentTime: TimeInterval) {
        
        if startTime == -1 {
            startTime = currentTime
            startTime1 = currentTime
        }
        
        if currentTime - startTime1 > 5 {
            if countHeightIndex < 5 || countWidthIndex < 5 {
                addFlies(fiIndexWidth: countWidthIndex, fiIndexHeight: countHeightIndex)
                countHeightIndex += 1
                countWidthIndex += 1
            }
            if countWidthIndex == 5 && countHeightIndex == 5 {
                countHeightIndex -= 4
                countWidthIndex -= 4
                if countHeightIndex1 < 5 || countWidthIndex1 < 5 {
                    addFlies1(fiIndexWidth: countWidthIndex1, fiIndexHeight: countHeightIndex1)
                    countHeightIndex1 += 1
                    countWidthIndex1 += 1
                }
            }
            startTime1 = currentTime
        }
        
        if currentTime - startTime > 0.3 {
            playerShoot()
            startTime = currentTime
        }
        
        self.enumerateChildNodes(withName: PLAYER_BULLET_NAME) {
            node, pointer in
            if node.position.y > self.size.height {
                node.removeFromParent()
            }
        }
        
        self.enumerateChildNodes(withName: FLY_BULLET_NAME) {
            node, pointer in
            if node.position.y > self.size.height || node.position.y < 0{
                node.removeFromParent()
            }
        }
        
        
//        for playerBullets in self.playerBullets {
//            if playerBullets.position.y > self.size.height {
//                playerBullets.removeFromParent()
//            }
//        }
        
//        self.playerBullets = playerBullets.filter {
//            node in
//            return node.parent != nil
//        }
//        self.flies = flies.filter {
//            node in
//            return node.parent != nil
//        }
        
        
    }
    
    let PLAYER_BULLET_NAME = "Player bullets"
    let FLY_BULLET_NAME = "Fly bullets"
    
    func playerShoot() -> Void {
        let bulletNode = SKSpriteNode(imageNamed: "bullet-2.png")
        bulletNode.size = CGSize(width: 8, height: 13)
        bulletNode.name = PLAYER_BULLET_NAME
        bulletNode.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + playerNode.size.height)
        bulletNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: bulletNode.size)
        bulletNode.physicsBody?.categoryBitMask = Physicscategory.playerBullets
        bulletNode.physicsBody?.contactTestBitMask = Physicscategory.fly
        bulletNode.physicsBody?.collisionBitMask = 0
        bulletNode.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        bulletNode.physicsBody?.linearDamping = 0
        bulletNode.physicsBody?.mass = 0
        bulletNode.run(playerShootSoundAction)
        
        addChild(bulletNode)
        playerBullets.append(bulletNode)
    }
    func flyShoot(flyShootX: CGFloat, flyShootY: CGFloat) -> Void {
        let bulletNodeOfFly = SKSpriteNode(imageNamed: "bullet-1.png")
        bulletNodeOfFly.name = FLY_BULLET_NAME
        bulletNodeOfFly.size = CGSize(width: 10, height: 12)
        bulletNodeOfFly.anchorPoint = CGPoint(x: 0.5, y: 1)
        bulletNodeOfFly.zRotation = CGFloat(M_PI / 1)
        bulletNodeOfFly.position = CGPoint(x: flyShootX, y: flyShootY)
        bulletNodeOfFly.physicsBody = SKPhysicsBody(rectangleOf: bulletNodeOfFly.size)
        bulletNodeOfFly.physicsBody?.collisionBitMask = 0
        bulletNodeOfFly.physicsBody?.categoryBitMask = Physicscategory.flyBullets
        bulletNodeOfFly.physicsBody?.contactTestBitMask = Physicscategory.player
        bulletNodeOfFly.physicsBody?.velocity = CGVector(dx: 0, dy: -100)
        bulletNodeOfFly.physicsBody?.linearDamping = 0
        bulletNodeOfFly.physicsBody?.mass = 0
        //bulletNodeOfFly.run(SKAction.move(to: playerNode.position, duration: 1))
        
        addChild(bulletNodeOfFly)
        flies.append(bulletNodeOfFly)
    }
    func flyShoot1(flyShootX: CGFloat, flyShootY: CGFloat) -> Void {
        let bulletNodeOfFly = SKSpriteNode(imageNamed: "capture-wave-1.png")
        bulletNodeOfFly.name = FLY_BULLET_NAME
        bulletNodeOfFly.size = CGSize(width: self.size.width / 6, height: self.size.height / 9)
        bulletNodeOfFly.anchorPoint = CGPoint(x: 0.5, y: 1)
        bulletNodeOfFly.position = CGPoint(x: flyShootX, y: flyShootY)
        bulletNodeOfFly.physicsBody = SKPhysicsBody(rectangleOf: bulletNodeOfFly.size)
        bulletNodeOfFly.physicsBody?.collisionBitMask = 0
        bulletNodeOfFly.physicsBody?.categoryBitMask = Physicscategory.flyBullets1
        bulletNodeOfFly.physicsBody?.contactTestBitMask = Physicscategory.player
        bulletNodeOfFly.physicsBody?.velocity = CGVector(dx: 0, dy: -90)
        bulletNodeOfFly.physicsBody?.linearDamping = 0
        bulletNodeOfFly.physicsBody?.mass = 0
        //bulletNodeOfFly.run(SKAction.move(to: playerNode.position, duration: 1))
        
        addChild(bulletNodeOfFly)
        flies.append(bulletNodeOfFly)
    }

    
}
