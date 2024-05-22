//
//  GameScene.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 16/05/24.
//

import SpriteKit




class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameOverProtocol: GameOverProtocol? = nil
    var distanceProtocol: DistanceProtocol? = nil
    var timeProtocol: TimeProtocol? = nil
    
    let playerBody = PlayerBody()
    let playerLeftLeg = PlayerLeg()
    let playerRightLeg = PlayerLeg()
    
    let ground = SKShapeNode(rectOf: CGSize(width: generateTerrain(), height: 200))
    var lastGroundPosition = 0
    
    let joystickLeft = TLAnalogJoystick(withDiameter: 200)
    let joystickRight = TLAnalogJoystick(withDiameter: 200)
    
    let cam = SKCameraNode()
    var nextCamPosition = Screen.width.rawValue
    
    var obstacle: Array<SKSpriteNode> = []
    
    var timer: Int = 61
    var legAudioCooldown = 5
    
    override func didMove(to view: SKView) {
        
        view.isMultipleTouchEnabled = true
        self.backgroundColor = .clear
        view.allowsTransparency = true
        
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
        
        for pos in stride(from: lastGroundPosition - generateTerrain() / 2, to: lastGroundPosition + generateTerrain() / 2, by: 100){
            let coinFlip = Int.random(in: 0..<100)
            if coinFlip < 10 {
                addChild(Rock(x: CGFloat(pos)))
            }
        }
        
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
        }
        
        joystickRight.position = CGPoint(x: 1024 * 0.5 - joystickRight.radius - 50, y: 768 * -0.5 + joystickRight.radius + 50)
        joystickRight.zPosition = 5
        joystickRight.baseImage = UIImage(named: "joystick_back")
        joystickRight.handleImage = UIImage(named: "joystick_front")
        cam.addChild(joystickRight)
        joystickRight.on(.move) { [unowned self] data in
            playerRightLeg.zRotation = data.angular + .pi
        }
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(countdown), SKAction.wait(forDuration: (1))])))
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position.x = playerBody.position.x + 400
        if Int(cam.position.x) > nextCamPosition {
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
            
            for pos in stride(from: lastGroundPosition - generateTerrain() / 2, to: lastGroundPosition + generateTerrain() / 2, by: 100){
                let coinFlip = Int.random(in: 0..<100)
                if coinFlip < 10 {
                    addChild(Rock(x: CGFloat(pos)))
                }
            }
        }
        
        if var distanceProtocol = self.distanceProtocol {
            distanceProtocol.updateDistance(distance: Int(playerBody.position.x / 100))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        let sortedNodes = [nodeA, nodeB].sorted { $0.name ?? "" < $1.name ?? ""}
        
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if firstNode.physicsBody?.categoryBitMask == CollisionCategory.playerBody.rawValue || secondNode.physicsBody?.categoryBitMask == CollisionCategory.playerBody.rawValue {
            handleBodyCollision(contact: contact)
        }else if firstNode.physicsBody?.categoryBitMask == CollisionCategory.playerLeg.rawValue || secondNode.physicsBody?.categoryBitMask == CollisionCategory.playerLeg.rawValue {
            handleLegCollision(contact: contact)
        }
    }
    
    func handleBodyCollision(contact: SKPhysicsContact) {
        var envBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask == CollisionCategory.playerBody.rawValue {
            envBody = contact.bodyB
        } else{
            envBody = contact.bodyA
        }
        
        switch envBody.categoryBitMask{
            case CollisionCategory.ground.rawValue:
                let playGameOverSound = SKAction.playSoundFileNamed(ResourceHandler.sound.gameComplete, waitForCompletion: true)
                self.run(playGameOverSound)
                gameOver()
            
            default:
            break
            
        }
    }
    
    func handleLegCollision(contact: SKPhysicsContact) {
        guard legAudioCooldown <= 0 else {
            legAudioCooldown -= 1
            return
        }
        legAudioCooldown = 5
        var envBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask == CollisionCategory.playerLeg.rawValue {
            envBody = contact.bodyB
        } else{
            envBody = contact.bodyA
        }
        
        switch envBody.categoryBitMask{
            //TODO: too laggy, please fix
//            case CollisionCategory.ground.rawValue:
//                let playStepSound = SKAction.playSoundFileNamed(ResourceHandler.sound.groundStep, waitForCompletion: true)
//                self.run(playStepSound)
            case CollisionCategory.rock.rawValue:
                let playRockSound = SKAction.playSoundFileNamed(ResourceHandler.sound.stoneHit, waitForCompletion: true)
                self.run(playRockSound)
            
            default:
            break
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func gameOver() {
        if var gameOverProtocol = self.gameOverProtocol {
            gameOverProtocol.setGameOver(value: true)
        }
        lastGroundPosition = 0
        nextCamPosition = Screen.width.rawValue
        camera?.removeAllActions()
        camera?.removeAllChildren()
        playerBody.removeAllActions()
        playerBody.removeAllChildren()
        self.removeAllActions()
        self.removeAllChildren()
    }
    
    func countdown() {
        timer -= 1
        if var timeProtocol = self.timeProtocol {
            timeProtocol.updateTime(time: timer)
        }
        if timer <= 0{
            gameOver()
        }else if timer < 10 {
            run(SKAction.playSoundFileNamed(ResourceHandler.sound.countdown, waitForCompletion: true))
        }
    }
    
}
