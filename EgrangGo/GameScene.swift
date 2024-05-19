//
//  GameScene.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 16/05/24.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let playerBody = PlayerBody()
    let playerLeftLeg = PlayerLeg()
    let playerRightLeg = PlayerLeg()
    let ground = SKShapeNode(rectOf: CGSize(width: 1024, height: 200))
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
//        physicsWorld.gravity = .zero
        if let leaf = SKEmitterNode(fileNamed: "LeafBlowParticle"){
            leaf.position = CGPoint(x:1080, y: 0)
            leaf.zPosition = -1
        }
        
        playerLeftLeg.name = "playerLeftLeg"
        playerRightLeg.name = "playerRightLeg"
        
//        playerBody.zPosition = 2
//        playerLeftLeg.zPosition = 3
//        playerRightLeg.zPosition = 1
        
//        playerLeftLeg.position.y = -100
//        playerLeftLeg.zRotation = 90
//        playerRightLeg.position.y = -100
//        playerRightLeg.anchorPoint = CGPoint(x: 0.3, y: 0.85)
//        playerRightLeg.zRotation = -90
        
        addChild(playerBody)
        playerBody.addChild(playerLeftLeg)
        playerBody.addChild(playerRightLeg)
        
        let bodyLeftLegJoint = SKPhysicsJointPin.joint(withBodyA: playerBody.physicsBody!, bodyB: playerLeftLeg.physicsBody!, anchor: CGPoint(x: playerBody.position.x, y: playerBody.position.y - 50))
        physicsWorld.add(bodyLeftLegJoint)
        
        
        let bodyRightLegJoint = SKPhysicsJointPin.joint(withBodyA: playerBody.physicsBody!, bodyB: playerRightLeg.physicsBody!, anchor: playerBody.position)
        physicsWorld.add(bodyRightLegJoint)
        
        ground.strokeColor = .ground
        ground.fillColor = .ground
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1024, height: 200))
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        ground.position.x = 0
        ground.position.y = -frame.height / 2
        addChild(ground)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerLeftLeg.run(SKAction.rotate(byAngle: .pi / 2, duration: 1.0))
        playerRightLeg.run(SKAction.rotate(byAngle: -.pi / 2, duration: 1.0))
    }
    
    func setCamera() {
        let camera = SKCameraNode()
        camera.setScale(1)
        addChild(camera)
        scene!.camera = camera
    }
}
