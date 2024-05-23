//
//  InvisibleBarrier.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 23/05/24.
//

import Foundation
import SpriteKit

func generateInvisibleBarrier(scene: SKScene) {
    var invisibleBarrier = SKShapeNode(rectOf: CGSize(width: Screen.width.rawValue / 12, height: Screen.height.rawValue))
    invisibleBarrier.strokeColor = .clear
    invisibleBarrier.position.x = -500
    invisibleBarrier.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Screen.width.rawValue / 12, height: Screen.height.rawValue))
    invisibleBarrier.physicsBody?.categoryBitMask = CollisionCategory.barrier.rawValue
    invisibleBarrier.physicsBody?.collisionBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
    invisibleBarrier.physicsBody?.contactTestBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
    invisibleBarrier.physicsBody?.affectedByGravity = false
    invisibleBarrier.physicsBody?.isDynamic = false
    scene.addChild(invisibleBarrier)
}
