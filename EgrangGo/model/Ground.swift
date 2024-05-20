//
//  Ground.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 20/05/24.
//

import Foundation
import SpriteKit

class Ground: SKShapeNode {
    init(xPos: Int, yPos: Int){
        super.init()
        
        path = CGPath(rect: CGRect(x: CGFloat(xPos), y: CGFloat(yPos), width: CGFloat(generateTerrain()), height: 200), transform: nil)
        strokeColor = .ground
        fillColor = .ground
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: generateTerrain(), height: 200))
        physicsBody?.categoryBitMask = CollisionCategory.ground.rawValue
        physicsBody?.collisionBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
        physicsBody?.contactTestBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.friction = 1
        
//        position.x = CGFloat(xPos)
//        position.y = -frame.height / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
}
