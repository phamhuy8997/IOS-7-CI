//
//  GameScene1.swift
//  Homework
//
//  Created by Huy Pham on 3/15/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import SpriteKit

struct Physicscategory1 {
    static let fly : UInt32 = 1
    static let player : UInt32 = 2
    static let playerBullets : UInt32 = 3
    static let flyBullets : UInt32 = 4
}

class GameScene1: SKScene, SKPhysicsContactDelegate {
    
    let playerNode = SKSpriteNode(imageNamed: "player-1.png")
    let flyNode = SKSpriteNode(imageNamed: "fly-1-1.png")
    let xFly : CGFloat = 100
    let flyWidth : CGFloat = 20
    let flySpace : CGFloat = 20
    let screenSize = UIScreen.main.bounds
    var flies : [SKSpriteNode] = []
    
    var starfield:SKEmitterNode!
    //var scoreLabel:SKLabelNode!
    //var heathLabel:SKLabelNode!
    var scoreLabel : UILabel!
    var heathLabel : UILabel!
    var score : Int = 0
    var playerHealth : Int = 10

//    var score1:Int = 50 {
//            scoreLabel1.text = "Score: \(score1)"
//    }
//    var heath1:Int = 10 {
//            healthLabel1.text = "Health: \(heath1)"
//    }
    let fly1Texture = SKTexture(imageNamed: "fly-1-1")
    let fly2Texture = SKTexture(imageNamed: "fly-1-2")
    let fly3Texture = SKTexture(imageNamed: "fly-2-1")
    let fly4Texture = SKTexture(imageNamed: "fly-2-2")
    let playerShootSoundAction = SKAction.playSoundFileNamed("player-shoot.wav", waitForCompletion: false)
    let playerDiedSound = SKAction.playSoundFileNamed("attack-1.wav", waitForCompletion: false)
    
    let explosionTexture0 = SKTexture(imageNamed: "explosion-0")
    let explosionTexture1 = SKTexture(imageNamed: "explosion-1")
    let explosionTexture2 = SKTexture(imageNamed: "explosion-2")
    let explosionTexture3 = SKTexture(imageNamed: "explosion-3")
    
    let playerTexture1 = SKTexture(imageNamed: "explosion-2-1")
    let playerTexture2 = SKTexture(imageNamed: "explosion-2-2")
    let playerTexture3 = SKTexture(imageNamed: "explosion-2-3")
    let playerTexture4 = SKTexture(imageNamed: "explosion-2-4")
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0, y: 0)
        
        addStarfield()
        addPlayer()
        addFlies()
        configPhysics()
        
        scoreLabel = UILabel(frame: CGRect(x: 0, y: self.size.height - 20, width: 100, height: 20 ))
        scoreLabel.textColor = UIColor.red
        scoreLabel.text = "Score : \(score)"
        self.view?.addSubview(scoreLabel)
        
        heathLabel = UILabel(frame: CGRect(x: 0 , y: self.size.height - 40, width: 100, height: 20))
        heathLabel.textColor = UIColor.blue
        heathLabel.text = "Heath : \(playerHealth)"
        self.view?.addSubview(heathLabel)

    }
    
    func configPhysics() -> Void {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let location = firstTouch.location(in: self)
            print(location)
            playerNode.position.x = location.x
        }

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
            scoreLabel.text = "Score : \(score)"
            
           //addExplosion1(position: (nodeA?.position)!)
        }
        
        if ((bodyA.categoryBitMask == Physicscategory.flyBullets) && (bodyB.categoryBitMask == Physicscategory.player) || (bodyA.categoryBitMask == Physicscategory.player) && (bodyB.categoryBitMask == Physicscategory.flyBullets)) {
            playerHealth -= 1
            self.run(playerDiedSound)
            if playerHealth == 0 {
                    playerHealth -= 1
                    heathLabel.text = "Health : \(playerHealth)"
                }else if playerHealth < 0 {
                    playerHealth -= 1
                    heathLabel.text = "Health : \(playerHealth)"
                    
                    addPlayerExplosion(position: self.playerNode.position)
                    self.playerNode.removeFromParent()
                    let mh2 = ManHinh2Scene(size: self.size)
                    mh2.scaleMode = scaleMode
                    let reveal2 = SKTransition.fade(withDuration: 3)
                    self.view?.presentScene(mh2, transition: reveal2)
                }
        }
        
    }
    
    func addExplosion1(position: CGPoint) -> Void {
        let explosionNode = SKSpriteNode(imageNamed: "explosion-0")
        explosionNode.position = position
        let animateAction = SKAction.animate(with: [explosionTexture0, explosionTexture1, explosionTexture2, explosionTexture3], timePerFrame: 0.05)
        
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

    func addStarfield() -> Void {
        if let starfieldNode = SKEmitterNode(fileNamed: "starfield1.sks") {
            starfieldNode.position = CGPoint(x: self.size.width / 2, y: self.size.height)
            starfieldNode.zPosition = -100
            starfieldNode.particlePositionRange = CGVector(dx: self.size.width, dy: 0)
            addChild(starfieldNode)
        }
        
    }

    
    func addPlayer() -> Void {
        playerNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        playerNode.size = CGSize(width: self.size.width / 10, height: self.size.height / 15)
        playerNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 10)
        playerNode.physicsBody = SKPhysicsBody(rectangleOf: playerNode.size)
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.linearDamping = 0
        playerNode.physicsBody?.categoryBitMask = Physicscategory1.player
        playerNode.physicsBody?.contactTestBitMask = Physicscategory1.flyBullets
        addChild(playerNode)
    }
    
    func addFlies() -> Void {
        let flyXMid : CGFloat = size.width / 2
        let flyIndexMid : CGFloat = 2
        flyNode.size = CGSize(width: self.size.width / 12, height: self.size.height / 17)
        
        for flyIndex in 0..<5 {
            for flyIndex1 in 0..<2 {
                let SPACE = flyWidth + flySpace
                let flyX : CGFloat = flyXMid + (CGFloat(flyIndex) - flyIndexMid) * SPACE
                let flyY : CGFloat = size.height
                
                let flyNode = SKSpriteNode(imageNamed: "fly-2-1.png")
                flyNode.anchorPoint = CGPoint(x: 0.5, y: 1)
                flyNode.position = CGPoint(x: flyX, y: flyY - CGFloat(flyIndex1)*50)
                flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                
                var action = [SKAction]()
                action.append(SKAction.run {
                    self.flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                action.append(SKAction.moveTo(x:  flyNode.position.x + 50, duration: 3))
                action.append(SKAction.run {
                    self.flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                action.append(SKAction.moveTo(x: flyNode.position.x - 50, duration: 3))
                action.append(SKAction.run {
                    self.flyShoot(flyShootX: flyNode.position.x, flyShootY: flyNode.position.y)
                })
                flyNode.run(SKAction.repeatForever(SKAction.sequence(action)))
                
                flyNode.physicsBody = SKPhysicsBody(rectangleOf: flyNode.size)
                flyNode.physicsBody?.collisionBitMask = 0
                flyNode.physicsBody?.linearDamping = 0
                flyNode.physicsBody?.categoryBitMask = Physicscategory1.fly
                flyNode.physicsBody?.contactTestBitMask = Physicscategory1.playerBullets
                flyNode.physicsBody?.velocity = CGVector(dx: 0, dy: -40)
                
                flyNode.run(
                    .repeatForever(
                        .animate(with: [fly3Texture, fly4Texture], timePerFrame: 0.1)))
                addChild(flyNode)
                
                }
        }
        
    }

    var startTime: TimeInterval = -1
    var startTime1: TimeInterval = -1

    override func update(_ currentTime: TimeInterval) {
    
        if startTime == -1 {
            startTime = currentTime
        }
    
        if startTime1 == -1.5 {
            startTime1 = currentTime
        }
    
        if currentTime - startTime1 > 6 {
            addFlies()
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

    }
    
    let PLAYER_BULLET_NAME = "Player bullets"
    let FLY_BULLET_NAME = "Fly bullets"
    var countPlayerShoot : Int = 1
    func playerShoot() -> Void {
        countPlayerShoot += 1
        for countShoot in 1..<3 {
        let bulletNode = SKSpriteNode(imageNamed: "bullet-1.png")
        bulletNode.size = CGSize(width: 8, height: 13)
        bulletNode.name = PLAYER_BULLET_NAME
        bulletNode.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + playerNode.size.height)
        bulletNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: bulletNode.size)
        bulletNode.physicsBody?.categoryBitMask = Physicscategory1.playerBullets
        bulletNode.physicsBody?.contactTestBitMask = Physicscategory1.fly
        bulletNode.physicsBody?.collisionBitMask = 0
        bulletNode.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        bulletNode.physicsBody?.linearDamping = 0
        bulletNode.physicsBody?.mass = 0
        bulletNode.run(playerShootSoundAction)
            
        addChild(bulletNode)
        }
    }
    func flyShoot(flyShootX: CGFloat, flyShootY: CGFloat) -> Void {
        let bulletNodeOfFly = SKSpriteNode(imageNamed: "capture-wave-1.png")
        bulletNodeOfFly.name = FLY_BULLET_NAME
        bulletNodeOfFly.size = CGSize(width: 10, height: 12)
        bulletNodeOfFly.anchorPoint = CGPoint(x: 0.5, y: 1)
        bulletNodeOfFly.zRotation = CGFloat(M_PI / 1)
        bulletNodeOfFly.position = CGPoint(x: flyShootX, y: flyShootY)
        bulletNodeOfFly.physicsBody = SKPhysicsBody(rectangleOf: bulletNodeOfFly.size)
        bulletNodeOfFly.physicsBody?.collisionBitMask = 0
        bulletNodeOfFly.physicsBody?.categoryBitMask = Physicscategory1.flyBullets
        bulletNodeOfFly.physicsBody?.contactTestBitMask = Physicscategory1.player
        bulletNodeOfFly.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
        bulletNodeOfFly.physicsBody?.linearDamping = 0
        bulletNodeOfFly.physicsBody?.mass = 0
        //bulletNodeOfFly.run(SKAction.move(to: playerNode.position, duration: 3))
            
        addChild(bulletNodeOfFly)
        }
    }

