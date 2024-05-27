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
    let playerLeftLeg = PlayerLeg(name: "playerLeftLeg")
    let playerRightLeg = PlayerLeg(name: "playerRightLeg")
    
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
        
        generateGroundFeatures(lastGroundPosition: &lastGroundPosition, scene: self, isFirst: true)
        
        if let leaf = SKEmitterNode(fileNamed: "LeafBlowParticle"){
            leaf.position = CGPoint(x:1080, y: 0)
            leaf.zPosition = -1
        }
        
        addChild(playerBody)
        playerBody.addChild(playerLeftLeg)
        playerBody.addChild(playerRightLeg)
        
        let bodyLeftLegJoint = createBodyLegJoint(body: playerBody, leg: playerLeftLeg)
        physicsWorld.add(bodyLeftLegJoint)
        
        
        let bodyRightLegJoint = createBodyLegJoint(body: playerBody, leg: playerRightLeg)
        physicsWorld.add(bodyRightLegJoint)
        
        playerLeftLeg.zRotation = 5.6
        playerRightLeg.zRotation = 0.3
        
        cam.setScale(1.5)
        cam.position.y = 200
        self.camera = cam
        addChild(cam)
        
        generateInvisibleBarrier(scene: self)
        
        joystickLeft.position = CGPoint(x: CGFloat(Screen.width.rawValue) * -0.5 + joystickLeft.radius + 50, y: 768 * -0.5 + joystickLeft.radius + 50)
        joystickLeft.zPosition = 10
        joystickLeft.baseImage = UIImage(named: ResourceHandler.image.joystickBack)
        joystickLeft.handleImage = UIImage(named: ResourceHandler.image.joystickFront)
        cam.addChild(joystickLeft)
        
        joystickLeft.on(.move) { [unowned self] data in
            playerLeftLeg.zRotation = data.angular + .pi
        }
        
        joystickRight.position = CGPoint(x: CGFloat(Screen.width.rawValue) * 0.5 - joystickRight.radius - 50, y: 768 * -0.5 + joystickRight.radius + 50)
        joystickRight.zPosition = 10
        joystickRight.baseImage = UIImage(named: ResourceHandler.image.joystickBack)
        joystickRight.handleImage = UIImage(named: ResourceHandler.image.joystickFront)
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
            
            generateGroundFeatures(lastGroundPosition: &lastGroundPosition, scene: self, isFirst: false)
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
