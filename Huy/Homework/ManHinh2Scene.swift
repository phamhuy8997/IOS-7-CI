//
//  ManHinh2Scene.swift
//  Homework
//
//  Created by Huy Pham on 3/15/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import SpriteKit

class ManHinh2Scene: SKScene {
    let imageGameover = SKSpriteNode(imageNamed: "gameover.png")
    
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0, y: 0)
        
        imageGameover.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        imageGameover.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        imageGameover.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        addChild(imageGameover)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
