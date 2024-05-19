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
    
    let joystickLeft = TLAnalogJoystick(withDiameter: 200)
    let joystickRight = TLAnalogJoystick(withDiameter: 200)
    
    let cam = SKCameraNode()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        physicsWorld.gravity = CGVectorMake(0, -0.5)
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
        
        //starting rotation
        
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
        ground.physicsBody?.friction = 1
        ground.position.x = 0
        ground.position.y = -frame.height / 2
        addChild(ground)
        
        joystickLeft.position = CGPoint(x: 1024 * -0.5 + joystickLeft.radius + 50, y: 768 * -0.5 + joystickLeft.radius + 50)
        joystickLeft.zPosition = 5
        joystickLeft.baseImage = UIImage(named: "joystick_back")
        joystickLeft.handleImage = UIImage(named: "joystick_front")
        addChild(joystickLeft)
        joystickLeft.on(.move) { [unowned self] data in
            playerLeftLeg.zRotation = data.angular + .pi
            print("\(data.angular)")
        }
        
        joystickRight.position = CGPoint(x: 1024 * 0.5 - joystickRight.radius - 50, y: 768 * -0.5 + joystickRight.radius + 50)
        joystickRight.zPosition = 5
        joystickRight.baseImage = UIImage(named: "joystick_back")
        joystickRight.handleImage = UIImage(named: "joystick_front")
        addChild(joystickRight)
        joystickRight.on(.move) { [unowned self] jsData in
            playerRightLeg.zRotation = jsData.angular + .pi
            print("moving: \(jsData.angular)")
            
        }
        
//        cam.setScale(2)
//        self.camera = cam
    }
    
    override func update(_ currentTime: TimeInterval) {
//        cam.position = playerBody.position
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        playerLeftLeg.run(SKAction.rotate(byAngle: .pi / 2, duration: 1.0))
//        playerRightLeg.run(SKAction.rotate(byAngle: -.pi / 2, duration: 1.0))
    }
}
