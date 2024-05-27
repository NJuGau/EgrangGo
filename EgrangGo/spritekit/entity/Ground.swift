//
//  Ground.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 20/05/24.
//

import Foundation
import SpriteKit

func generateGroundFeatures(lastGroundPosition: inout Int, scene: SKScene, isFirst: Bool) {
    let ground = SKShapeNode(rectOf: CGSize(width: generateTerrain(), height: 200))
    ground.strokeColor = .ground
    ground.fillColor = .ground
    ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: generateTerrain(), height: 200))
    ground.physicsBody?.categoryBitMask = CollisionCategory.ground.rawValue
    ground.physicsBody?.collisionBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
    ground.physicsBody?.contactTestBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
    ground.physicsBody?.affectedByGravity = false
    ground.physicsBody?.isDynamic = false
    ground.physicsBody?.friction = 1
    ground.position.x = CGFloat(lastGroundPosition) + ((isFirst) ? 0 : CGFloat(generateTerrain()))
    ground.position.y = -scene.frame.height / 2
    ground.zPosition = 5
    scene.addChild(ground)
    lastGroundPosition = Int(ground.position.x)
    
    let startPosition = lastGroundPosition - generateTerrain() / 2
    let lastPosition = lastGroundPosition + generateTerrain() / 2
    for pos in stride(from: startPosition, to: lastPosition, by: 100){
        let coinFlip = Int.random(in: 0..<100)
        if coinFlip < 10 {
            scene.addChild(Rock(x: CGFloat(pos)))
        } else if coinFlip < 20 {
            scene.addChild(Tree(x: CGFloat(pos)))
        }
    }
}
