//
//  Player.swift
//  EgrangGo
//
//  Created by Nathanael Juan Gauthama on 18/05/24.
//

import SpriteKit

class PlayerBody: SKSpriteNode {
    init(){
        let txt = SKTexture(imageNamed: ResourceHandler.image.playerBody)
        
        super.init(texture: txt, color: .white, size: txt.size())
        
        name = "playerBody"
        physicsBody = SKPhysicsBody(texture: texture!, size: texture!.size())
        physicsBody?.categoryBitMask = CollisionCategory.playerBody.rawValue
        physicsBody?.collisionBitMask = CollisionCategory.ground.rawValue | CollisionCategory.rock.rawValue | CollisionCategory.cat.rawValue
        physicsBody?.contactTestBitMask = CollisionCategory.ground.rawValue | CollisionCategory.rock.rawValue | CollisionCategory.cat.rawValue
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.mass = 50
        physicsBody?.angularDamping = 0.5
        physicsBody?.restitution = 0.0
        //positioning
        position.y = 105
        zPosition = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
}

class PlayerLeg: SKSpriteNode {
    init(name: String){
        let txt = SKTexture(imageNamed: (name == "playerRightLeg") ? ResourceHandler.image.playerRightLeg : ResourceHandler.image.playerLeftLeg)
                
        super.init(texture: txt, color: .white, size: txt.size())
        self.name = name
        physicsBody = SKPhysicsBody(texture: texture!, size: texture!.size())
        physicsBody?.categoryBitMask = CollisionCategory.playerLeg.rawValue
        physicsBody?.collisionBitMask = CollisionCategory.ground.rawValue | CollisionCategory.rock.rawValue | CollisionCategory.cat.rawValue
        physicsBody?.contactTestBitMask = CollisionCategory.ground.rawValue | CollisionCategory.rock.rawValue | CollisionCategory.cat.rawValue
        physicsBody?.mass = 80
        physicsBody?.friction = 1
        position.y = -195
        position.x = 50
        zPosition = -1
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
}
