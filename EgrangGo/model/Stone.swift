//
//  Stone.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 20/05/24.
//

import Foundation
import SpriteKit

class Rock: SKSpriteNode {
    init(x: CGFloat){
        let texture = SKTexture(imageNamed: ResourceHandler.image.rock)
        super.init(texture: texture, color: .white, size: texture.size())
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody?.categoryBitMask = CollisionCategory.rock.rawValue
        physicsBody?.collisionBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
        physicsBody?.contactTestBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
        physicsBody?.isDynamic = true
        physicsBody?.friction = 1
        physicsBody?.pinned = true
        physicsBody?.allowsRotation = false
        position.x = x
        position.y = CGFloat(-Screen.height.rawValue/2 + 100)
        zPosition = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
