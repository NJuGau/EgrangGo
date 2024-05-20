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
    
    let ground = SKShapeNode(rectOf: CGSize(width: generateTerrain(), height: 200))
    var lastGroundPosition = 0
    
    let rock1 = Rock(x: 300)
    let rock2 = Rock(x: 0)
//    var points = GroundRigid().generatePoints()
//    let groundRigid = SKShapeNode(points: &points, count: points.count)
    
    let joystickLeft = TLAnalogJoystick(withDiameter: 200)
    let joystickRight = TLAnalogJoystick(withDiameter: 200)
    
    let cam = SKCameraNode()
    var nextCamPosition = Screen.width.rawValue
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        ground.strokeColor = .ground
        ground.fillColor = .ground
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: generateTerrain(), height: 200))
        ground.physicsBody?.categoryBitMask = CollisionCategory.ground.rawValue
        ground.physicsBody?.collisionBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
        ground.physicsBody?.contactTestBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.friction = 1
        ground.position.x = CGFloat(lastGroundPosition)
        ground.position.y = -frame.height / 2
        addChild(ground)
        
//        physicsWorld.gravity = CGVectorMake(1, 1)
        if let leaf = SKEmitterNode(fileNamed: "LeafBlowParticle"){
            leaf.position = CGPoint(x:1080, y: 0)
            leaf.zPosition = -1
        }
        
        playerLeftLeg.name = "playerLeftLeg"
        playerRightLeg.name = "playerRightLeg"
        
        addChild(playerBody)
        playerBody.addChild(playerLeftLeg)
        playerBody.addChild(playerRightLeg)
        
        
        
        let bodyLeftLegJoint = SKPhysicsJointPin.joint(withBodyA: playerBody.physicsBody!, bodyB: playerLeftLeg.physicsBody!, anchor: CGPoint(x: playerBody.position.x, y: playerBody.position.y - 50))
        physicsWorld.add(bodyLeftLegJoint)
        
        
        let bodyRightLegJoint = SKPhysicsJointPin.joint(withBodyA: playerBody.physicsBody!, bodyB: playerRightLeg.physicsBody!, anchor: playerBody.position)
        physicsWorld.add(bodyRightLegJoint)
        
        //starting rotation
        playerLeftLeg.zRotation = 5.6
        playerRightLeg.zRotation = 0.3
        
        cam.setScale(1.5)
        cam.position.y = 200
        self.camera = cam
        addChild(cam)
        
        joystickLeft.position = CGPoint(x: 1024 * -0.5 + joystickLeft.radius + 50, y: 768 * -0.5 + joystickLeft.radius + 50)
        joystickLeft.zPosition = 5
        joystickLeft.baseImage = UIImage(named: "joystick_back")
        joystickLeft.handleImage = UIImage(named: "joystick_front")
        cam.addChild(joystickLeft)
        
        joystickLeft.on(.move) { [unowned self] data in
            playerLeftLeg.zRotation = data.angular + .pi
            print("angular: \(data.angular)")
            print("player left leg: \(playerLeftLeg.zRotation)")
            
            //confused using animation
//            let diffPos = abs(data.angular + .pi - playerLeftLeg.zRotation)
//            let diffNeg = abs(2 * .pi - (data.angular + .pi)) + abs(playerLeftLeg.zRotation)
//            
//            if(diffPos > diffNeg) {
//                playerLeftLeg.run(SKAction.rotate(byAngle: diffPos, duration: 0.5))
//            }else{
//                playerLeftLeg.run(SKAction.rotate(byAngle: -diffNeg, duration: 1.0))
//            }
        }
        
        joystickRight.position = CGPoint(x: 1024 * 0.5 - joystickRight.radius - 50, y: 768 * -0.5 + joystickRight.radius + 50)
        joystickRight.zPosition = 5
        joystickRight.baseImage = UIImage(named: "joystick_back")
        joystickRight.handleImage = UIImage(named: "joystick_front")
        cam.addChild(joystickRight)
        joystickRight.on(.move) { [unowned self] data in
            playerRightLeg.zRotation = data.angular + .pi
            print("angular: \(data.angular)")
            print("player right leg: \(playerRightLeg.zRotation)")
            
        }
        
        addChild(rock1)
//        addChild(rock2)
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position.x = playerBody.position.x + 400
        if Int(cam.position.x) > nextCamPosition {
            print("Make new ground")
            nextCamPosition = Int(cam.position.x) + generateTerrain()
            let newGround = SKShapeNode(rectOf: CGSize(width: generateTerrain(), height: 200))
            newGround.strokeColor = .ground
            newGround.fillColor = .ground
            newGround.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: generateTerrain(), height: 200))
            newGround.physicsBody?.categoryBitMask = CollisionCategory.ground.rawValue
            newGround.physicsBody?.collisionBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
            newGround.physicsBody?.contactTestBitMask = CollisionCategory.playerBody.rawValue | CollisionCategory.playerLeg.rawValue
            newGround.physicsBody?.affectedByGravity = false
            newGround.physicsBody?.isDynamic = false
            newGround.physicsBody?.friction = 1
            newGround.position.x = CGFloat(lastGroundPosition) + CGFloat(generateTerrain())
            newGround.position.y = -frame.height / 2
            lastGroundPosition = Int(newGround.position.x)
            addChild(newGround)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        playerLeftLeg.run(SKAction.rotate(byAngle: .pi / 2, duration: 1.0))
//        playerRightLeg.run(SKAction.rotate(byAngle: -.pi / 2, duration: 1.0))
    }
}
